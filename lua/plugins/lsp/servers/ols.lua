---@type string
local mason_ols = vim.fn.stdpath("data") .. "/mason/bin/ols"
---@type string
local cmd = (vim.fn.executable(mason_ols) == 1) and mason_ols or "ols"

local odin_lib = vim.env.ODIN_LIB
if not odin_lib then
  local default_odin_lib = vim.fs.joinpath(vim.env.HOME or vim.fn.expand("~"), "odin-lib")
  if vim.fn.isdirectory(default_odin_lib) == 1 then
    odin_lib = default_odin_lib
  end
end

local init_options = {
  checker_args = "-strict-style",
}
if odin_lib then
  init_options.collections = {
    { name = "shared", path = odin_lib },
  }
end

---@type vim.lsp.Config
return {
  cmd = { cmd },
  filetypes = { "odin" },
  root_markers = { "ols.json", "main.odin", ".git" },
  init_options = init_options,
}
