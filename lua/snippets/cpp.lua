---@type table<string, any>
local ls = require("luasnip")
---@type fun(trigger: string, nodes: any): any
local s = ls.snippet
---@type fun(text: string|string[]): any
local t = ls.text_node
---@type fun(position: integer, text?: string): any
local i = ls.insert_node
---@type fun(fn: function, args: table): any
local f = ls.function_node

---@type table<integer, any>
local snippets = {
  s("leetcode", {
    t({ "#include <iostream>", "" }),
    t({ "#include <vector>", "" }),
    t({ "#include <algorithm>", "", "" }),
    t({ "using namespace std;", "", "" }),
    t({ "int main() {", "" }),
    t({ "  return 0;", "" }),
    t({ "}" }),
  }),
}

---@return table<integer, any>
return snippets
