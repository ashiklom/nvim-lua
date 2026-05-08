--- overseer template: pixi.toml tasks
--- Place this file at:
---   ~/.config/nvim/lua/overseer/template/pixi.lua

local overseer = require("overseer")

---@type overseer.TemplateFileProvider
return {
  generator = function(opts, cb)
    if vim.fn.executable("pixi") == 0 then
      return 'Command "pixi" not found'
    end

    overseer.builtin.system(
      { "pixi", "task", "list", "--json" },
      { cwd = opts.dir, text = true },
      vim.schedule_wrap(function(out)
        if out.code ~= 0 then
          cb({})
          return
        end

        local ok, data = pcall(vim.json.decode, out.stdout, { luanil = { object = true } })
        if not ok then
          cb(string.format("pixi produced invalid json: %s", data))
          return
        end

        local ret = {}
        local seen = {}

        -- JSON structure: array of environments, each with features, each with tasks
        for _, env in ipairs(data) do
          for _, feature in ipairs(env.features or {}) do
            for _, task in ipairs(feature.tasks or {}) do
              if not seen[task.name] then
                seen[task.name] = true

                -- Build overseer params from pixi task args
                local params_defn = {}
                local ordered_args = {}
                for _, arg in ipairs(task.args or {}) do
                  params_defn[arg.name] = {
                    type     = "string",
                    desc     = arg.choices
                      and ("Choices: " .. table.concat(arg.choices, ", "))
                      or nil,
                    default  = arg.default,
                    optional = arg.default ~= nil,
                  }
                  table.insert(ordered_args, arg.name)
                end

                local tags = { overseer.TAG.BUILD }
                if task.name:match("test") then
                  tags = { overseer.TAG.TEST }
                elseif task.name:match("run") or task.name:match("start") or task.name:match("serve") then
                  tags = { overseer.TAG.RUN }
                end

                table.insert(ret, {
                  name   = string.format("pixi: %s", task.name),
                  desc   = task.description or ("Run pixi task: " .. task.name),
                  tags   = tags,
                  params = params_defn,
                  builder = function(params)
                    local cmd = { "pixi", "run", task.name }
                    for _, arg_name in ipairs(ordered_args) do
                      local v = params[arg_name]
                      if v and v ~= "" then
                        table.insert(cmd, v)
                      end
                    end
                    return {
                      cmd        = cmd,
                      cwd        = opts.dir,
                      components = { "default" },
                    }
                  end,
                })
              end
            end
          end
        end

        cb(ret)
      end)
    )
  end,
}
