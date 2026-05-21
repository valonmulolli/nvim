---@type vim.lsp.Config
---@type vim.lsp.Config
return {
  cmd = {
    "clangd",
    "--background-index",
    "--header-insertion=never",
    "--clang-tidy",
    "--completion-style=detailed",
    "--pch-storage=memory",
  },

  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },

  root_markers = {
    "compile_commands.json",
    "compile_flags.txt",
    ".clangd",
    "Kbuild",
    ".git",
  },
}
