---@type table<string, any>
local ls = require("luasnip")
---@type fun(trigger: string, nodes: any): any
local s = ls.snippet
---@type fun(text: string|string[]): any
local t = ls.text_node
---@type fun(position: integer, text?: string): any
local i = ls.insert_node

---@type table<integer, any>
local snippets = {
  s("sel", {
    t("SELECT "),
    i(1, "columns"),
    t(" FROM "),
    i(2, "table"),
    t(" WHERE "),
    i(3, "condition"),
    t(";"),
  }),

  s("ins", {
    t("INSERT INTO "),
    i(1, "table"),
    t(" ("),
    i(2, "columns"),
    t(") VALUES ("),
    i(3, "values"),
    t(");"),
  }),

  s("upd", {
    t("UPDATE "),
    i(1, "table"),
    t(" SET "),
    i(2, "column = value"),
    t(" WHERE "),
    i(3, "condition"),
    t(";"),
  }),
}

---@return table<integer, any>
return snippets
