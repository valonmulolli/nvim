---@type vim.lsp.Config
return {
  cmd = { vim.fs.joinpath(vim.env.HOME or "~", ".local", "bin", "qmlls"), "-E" },
  filetypes = { "qml", "qmljs" },
  root_markers = { ".qmlls.ini", "shell.qml", ".qmlproject", "CMakeLists.txt", ".git" },
  single_file_support = true,
}
