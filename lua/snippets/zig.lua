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
  -- Import std snippet
  s("std", {
    t('const std = @import("std");'),
  }),
  -- Import snippet
  s("imp", {
    t("const "),
    i(1, "name"),
    t(' = @import("'),
    i(2, "module"),
    t('");'),
  }),
  s("stru", {
    t({ "const " }),
    i(1, ""),
    t({ " = struct {", "\t" }),
    i(2, ""),
    t({ "", "};" }),
  }),
  -- Main function
  s("main", {
    t({ "pub fn main() !void {", "\t" }),
    i(1, "// code here"),
    t({ "", "}" }),
  }),
  -- Generic function
  s("fn", {
    t({ "fn " }),
    i(1, "functionName"),
    t({ "(" }),
    i(2, "params"),
    t({ ") " }),
    i(3, "returnType"),
    t({ " {", "\t" }),
    i(4, "// body"),
    t({ "", "}" }),
  }),
  -- If statement
  s("if", {
    t({ "if (" }),
    i(1, "condition"),
    t({ ") {", "\t" }),
    i(2, "// then"),
    t({ "", "}" }),
  }),
  -- If-else statement
  s("ife", {
    t({ "if (" }),
    i(1, "condition"),
    t({ ") {", "\t" }),
    i(2, "// then"),
    t({ "", "} else {", "\t" }),
    i(3, "// else"),
    t({ "", "}" }),
  }),
  -- While loop
  s("while", {
    t({ "while (" }),
    i(1, "condition"),
    t({ ") {", "\t" }),
    i(2, "// body"),
    t({ "", "}" }),
  }),
  -- For loop over slice/array
  s("for", {
    t({ "for (" }),
    i(1, "items"),
    t({ ") |" }),
    i(2, "item"),
    t({ "| {", "\t" }),
    i(3, "// body"),
    t({ "", "}" }),
  }),
  -- Try-catch for errors
  s("try", {
    t({ "try " }),
    i(1, "expression"),
    t({ ";" }),
  }),
  -- Defer statement
  s("defer", {
    t({ "defer " }),
    i(1, "statement"),
    t({ ";" }),
  }),
  -- Enum
  s("enum", {
    t({ "const " }),
    i(1, "EnumName"),
    t({ " = enum {", "\t" }),
    i(2, "Value1,\n\tValue2,"),
    t({ "", "};" }),
  }),
}

---@return table<integer, any>
return snippets
