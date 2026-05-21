---@type string
local mason_ols = vim.fn.stdpath("data") .. "/mason/bin/ols"
---@type string
local cmd = (vim.fn.executable(mason_ols) == 1) and mason_ols or "ols"

---@type vim.lsp.Config
return {
  cmd = { cmd },
  filetypes = { "odin" },
  root_markers = { "ols.json", "main.odin", ".git" },
  init_options = {
    checker_args = "-strict-style",
    collections = {
      { name = "shared", path = vim.fn.expand("$HOME/odin-lib") },
    },
  },
}
