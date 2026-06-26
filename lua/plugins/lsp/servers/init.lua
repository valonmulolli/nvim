---@class plugins.lsp.servers.Module
---@field configs table<string, vim.lsp.Config>
---@field enable string[]
---@field executables table<string, string>

---@type plugins.lsp.servers.Module
local M = {}

---@type table<string, vim.lsp.Config>
M.configs = {
  lua_ls = require("plugins.lsp.servers.lua_ls"),
  clangd = require("plugins.lsp.servers.clangd"),
  gopls = require("plugins.lsp.servers.gopls"),

  pyright = require("plugins.lsp.servers.pyright"),
  qmlls = require("plugins.lsp.servers.qmlls"),
  zls = require("plugins.lsp.servers.zls"),
  ols = require("plugins.lsp.servers.ols"),
  rust_analyzer = require("plugins.lsp.servers.rust-analyzer"),
  jdtls = require("plugins.lsp.servers.jdtls"),
}

---@type string[]
M.enable = {
  "lua_ls",
  "clangd",
  "gopls",
  "pyright",
  "qmlls",
  "zls",
  "rust_analyzer",
  "jdtls",
  "bashls",
  "html",
  "cssls",
  "jsonls",
  "yamlls",
  "tailwindcss",
  "tinymist",
  "emmet_ls",
  "fortls",
  "marksman",
  "astro",
  "templ",
  "prismals",
  "texlab",
  -- "intelephense",
  "hyprls",
  "wgsl_analyzer",
  "ols",
}

---@type table<string, string>
M.executables = {
  lua_ls = "lua-language-server",
  clangd = "clangd",
  gopls = "gopls",

  pyright = "pyright-langserver",
  qmlls = "qmlls",
  zls = "zls",
  rust_analyzer = "rust-analyzer",
  jdtls = "jdtls",
  bashls = "bash-language-server",
  html = "vscode-html-language-server",
  cssls = "vscode-css-language-server",
  jsonls = "vscode-json-language-server",
  yamlls = "yaml-language-server",
  tailwindcss = "tailwindcss-language-server",
  tinymist = "tinymist",
  emmet_ls = "emmet-ls",
  fortls = "fortls",
  marksman = "marksman",
  astro = "astro-ls",
  templ = "templ",
  prismals = "prisma-language-server",
  texlab = "texlab",
  -- intelephense = "intelephense",
  hyprls = "hyprls",
  wgsl_analyzer = "wgsl-analyzer",
  ols = "ols",
}

---@return plugins.lsp.servers.Module
return M
