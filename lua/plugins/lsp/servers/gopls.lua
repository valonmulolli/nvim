---@type vim.lsp.Config
return {
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.work", "go.mod", ".git" },
  settings = {
    gopls = {
      gofumpt = true,
      analyses = { unusedparams = true, nilness = true },
    },
  },
}
