local M = {}

---@class plugins.LuaSnipSnippetMap
---@field c string
---@field cpp string
---@field zig string
---@field sql string
---@field markdown string
---@field text string

function M.setup()
  ---@type table<string, any>
  local ls = require("luasnip")
  ls.setup({})

  require("luasnip.loaders.from_vscode").lazy_load()

  ---@type plugins.LuaSnipSnippetMap
  local snippet_modules = {
    c = "snippets.c",
    cpp = "snippets.cpp",
    zig = "snippets.zig",
    sql = "snippets.sql",
    markdown = "snippets.notes",
    text = "snippets.notes",
  }

  for ft, module_name in pairs(snippet_modules) do
    ---@type boolean, any
    local ok, ft_snippets = pcall(require, module_name)
    if ok and type(ft_snippets) == "table" then
      ls.add_snippets(ft, ft_snippets)
    end
  end
end

return M
