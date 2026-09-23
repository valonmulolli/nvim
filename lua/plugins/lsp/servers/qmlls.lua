local qmlls = vim.fn.exepath("qmlls")

---@type vim.lsp.Config
return {
  cmd = { qmlls ~= "" and qmlls or "qmlls", "-E" },
  filetypes = { "qml", "qmljs" },
  root_markers = { ".qmlls.ini", "shell.qml", ".qmlproject", "CMakeLists.txt", ".git" },
  single_file_support = true,
}
