-- mason.nvim | Portable package manager for Neovim
-- https://github.com/williamboman/mason.nvim

---@type LazyPluginSpec[]
return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = { "Mason", "MasonLog", "MasonUninstall", "MasonUninstallAll", "MasonUpdate" },
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<leader>pm", "<cmd>Mason<CR>", desc = "Show mason" },
    },
    opts = {
      ui = {
        height = 0.8,
        border = vim.g.border,
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    cmd = { "LspInstall", "LspUninstall" },
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      automatic_installation = false,
      ensure_installed = {
        "bashls",
        "clangd",
        "gopls",
        "cssls",
        "dockerls",
        "html",
        "jsonls",
        "ruff",
        "pyright",
        "taplo",
        "emmet_ls",
        "tailwindcss",
        "jsonls",
      },
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    cmd = { "NullLsInstall", "NullLsUninstall" },
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      automatic_installation = false,
      ensure_installed = {
        "typescript-language-server",
        "tailwindcss-language-server",
        "black",
        "isort",
        "clang-format",
        'debugpy',
        'flake8',
        'mypy',
        'pylint',
        "gofumpt",
        "goimports",
        "markdownlint",
        "prettier",
        "selene",
        "shfmt",
        "stylua",
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    cmd = { "DapInstall", "DapUninstall" },
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      automatic_installation = false,
      automatic_setup = true,
      ensure_installed = {},
    },
  },
}
