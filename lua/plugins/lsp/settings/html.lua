-- html-lsp: Language-server configuration
-- https://github.com/microsoft/vscode-html-languageservice

return {
  settings = {
    html = {
      format = {
        templating = true,
        wrapLineLength = 140,
        wrapAttributes = "auto",
      },
      hover = {
        documentation = true,
        references = true,
      },
    },
  },
}
