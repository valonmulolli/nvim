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

-- ∀∃□¬∨∧∑λ∈∅

---@return string
local function get_date()
  return os.date("%m-%d-%Y")
end

---@type table<integer, any>
local snippets = {

  -- latex
  s("$", {
    t({ "$$", "" }),
    i(1, ""),
    t({ "", "$$" }),
  }),

  -- math plain text snippets
  s("lam", t("λ")),
  s("lsm", t("∃")),
  s("lal", t("∀")),
  s("land", t("∧")),
  s("lor", t("∨")),
  s("lnot", t("¬")),
  s("lin", t("∈")),
  s("nil", t("∅")),
  s("summ", t("∑")),

  -- people
  s("VM", t("Valon Mulolli")),
  s("Sim", t("Simone de Beauvoir")),
  s("Gabriel", t("Gabriel Marcel")),

  -- gen words
  s("exist", t("existentialist")),
  s("phil", t("philosophy")),
  s("phil", t("philosophical")),
  s("bec", t("because")),
  s("there", t("therefore")),
  s("math", t("mathematical")),
  s("org", t("organization")),
  s("cs", t("computer Science")),
  s("pe", t("people")),
  s("pe", t("person")),
  s("dif", t("different")),

  -- misc

  s("head", {
    t({ "-- Valon Mulolli", "" }),
    t("-- Date: "),
    f(get_date, {}),
    t({ "", "-- Title: " }),
    i(1, "add title here"),
  }),
  -- markdown stuff
  s("td", t("- [ ]")),
  s("td", t("- [x]")),
}

---@return table<integer, any>
return snippets
