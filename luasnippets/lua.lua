local ls = require('luasnip')
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require('luasnip.extras.fmt').fmt

return {
  ls.snippet("snip", {
    t({
      "local ls = require('luasnip')",
      "local t = ls.text_node",
      "local i = ls.insert_node",
      "local f = ls.function_node",
      "local fmt = require('luasnip.extras.fmt').fmt"
    })
  })
}
