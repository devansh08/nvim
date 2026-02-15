-- Reference: https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s("ernil", {
    t({ "if err != nil {", "  panic(err)", "}" }),
  }),
  s(
    "fmtpl",
    fmt([[fmt.Println("{}", {})]], {
      i(1, "message"),
      i(2, "variable"),
    })
  ),

  s(
    "fmtp",
    fmt([[fmt.Printf("{}\n", {})]], {
      i(1, "message"),
      i(2, "variable"),
    })
  ),
}
