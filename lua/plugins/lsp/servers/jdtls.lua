---@type vim.lsp.Config
return {
  filetypes = { "java" },
  root_markers = { "build.gradle", "pom.xml", "settings.gradle" },
  cmd = {
    "jdtls",
    "-data", vim.fn.stdpath("data") .. "/jdtls-workspace",
    "-configuration", vim.fn.stdpath("data") .. "/mason/packages/jdtls/config_linux",
  },
}
