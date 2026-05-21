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
  -- Include directive
  s("inc", {
    t("#include <"),
    i(1, "header"),
    t(">"),
  }),

  -- Main function
  s("main", {
    t({ "int main(int argc, char *argv[]) {", "\t" }),
    i(1, "// code here"),
    t({ "", "\treturn 0;", "}" }),
  }),

  -- Function definition
  s("fn", {
    i(1, "returnType"),
    t(" "),
    i(2, "functionName"),
    t("("),
    i(3, "params"),
    t({ ") {", "\t" }),
    i(4, "// body"),
    t({ "", "}" }),
  }),

  -- If statement
  s("if", {
    t("if ("),
    i(1, "condition"),
    t({ ") {", "\t" }),
    i(2, "// then"),
    t({ "", "}" }),
  }),

  -- If-else statement
  s("ife", {
    t("if ("),
    i(1, "condition"),
    t({ ") {", "\t" }),
    i(2, "// then"),
    t({ "", "} else {", "\t" }),
    i(3, "// else"),
    t({ "", "}" }),
  }),

  -- While loop
  s("while", {
    t("while ("),
    i(1, "condition"),
    t({ ") {", "\t" }),
    i(2, "// body"),
    t({ "", "}" }),
  }),

  -- For loop
  s("for", {
    t("for ("),
    i(1, "init"),
    t("; "),
    i(2, "condition"),
    t("; "),
    i(3, "increment"),
    t({ ") {", "\t" }),
    i(4, "// body"),
    t({ "", "}" }),
  }),

  -- Struct definition
  s("struct", {
    t("struct "),
    i(1, "StructName"),
    t({ " {", "\t" }),
    i(2, "// fields"),
    t({ "", "};" }),
  }),

  -- Printf
  s("printf", {
    t('printf("'),
    i(1, "%s\\n"),
    t('", '),
    i(2, "var"),
    t(");"),
  }),

  -- Define macro
  s("def", {
    t("#define "),
    i(1, "MACRO"),
    t(" "),
    i(2, "value"),
  }),
}

---@return table<integer, any>
return snippets
