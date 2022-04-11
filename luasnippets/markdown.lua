local ls = require('luasnip')
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require('luasnip.extras.fmt').fmt

local function today()
  return os.date("%Y-%m-%d")
end

return{
  ls.snippet("hdr", {
    t({"---", ""}),
    t("title: "), i(1),
    t({"", "date: "}), f(today),
    t({"", "tags: "}), i(2),
    t({"", "---"})
  })
}
