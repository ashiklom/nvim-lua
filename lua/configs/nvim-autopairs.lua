local na = require('nvim-autopairs')

na.setup{
  ignored_nextchar = [=[[%w%%%'%[%"%.]]=],
  fast_wrap = {
    map = "<C-l>"
  }
}
