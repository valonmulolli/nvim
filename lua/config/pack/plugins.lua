local paths = require("config.paths")

local function gh(repo, opts)
  opts = opts or {}
  opts.src = "https://github.com/" .. repo
  return opts
end

local function build_zignite(path)
  local rust_manifest = vim.fs.joinpath(path, "rust", "Cargo.toml")
  if vim.fn.filereadable(rust_manifest) ~= 1 then
    error("zignite.nvim Rust backend manifest not found: " .. rust_manifest)
  end

  vim.system({ "cargo", "build", "--manifest-path", rust_manifest, "--release", "--locked" }, {
    cwd = path,
    text = true,
  }, function(result)
    if result.code ~= 0 then
      vim.schedule(function()
        vim.notify(
          "Build failed for zignite.nvim:\n" .. (result.stderr ~= "" and result.stderr or result.stdout),
          vim.log.levels.ERROR
        )
      end)
    end
  end)
end

local registry = {
  remote = {
    gh("saghen/blink.cmp", { name = "blink.cmp" }),
    gh("rafamadriz/friendly-snippets"),
    gh("nvim-tree/nvim-web-devicons"),
    gh("stevearc/conform.nvim"),
    gh("nvim-neotest/nvim-nio"),
    gh("mfussenegger/nvim-dap"),
    gh("rcarriga/nvim-dap-ui"),
    gh("tpope/vim-dadbod"),
    gh("kristijanhusak/vim-dadbod-ui"),
    gh("kristijanhusak/vim-dadbod-completion"),
    gh("folke/flash.nvim"),
    gh("lewis6991/gitsigns.nvim"),
    gh("S1M0N38/love2d.nvim"),
    gh("mason-org/mason.nvim"),
    gh("mason-org/mason-lspconfig.nvim"),
    gh("WhoIsSethDaniel/mason-tool-installer.nvim", { name = "mason-tool-installer.nvim" }),
    gh("neovim/nvim-lspconfig"),
    gh("iamcco/markdown-preview.nvim"),
    gh("monkoose/neocodeium"),
    gh("rmagatti/auto-session"),
    gh("folke/sidekick.nvim"),
    gh("nvim-lua/plenary.nvim"),
    gh("folke/snacks.nvim"),
    gh("L3MON4D3/LuaSnip", { name = "LuaSnip" }),
    gh("folke/todo-comments.nvim"),
    gh("nvim-treesitter/nvim-treesitter"),
    gh("windwp/nvim-ts-autotag"),
    gh("nvim-treesitter/nvim-treesitter-textobjects"),
    gh("hiphish/rainbow-delimiters.nvim"),
    gh("nvim-treesitter/nvim-treesitter-context"),
    gh("dmmulroy/tsc.nvim"),
    gh("dmmulroy/ts-error-translator.nvim"),
    gh("razak17/tailwind-fold.nvim"),
    gh("pmizio/typescript-tools.nvim"),
    gh("chomosuke/typst-preview.nvim"),
    gh("windwp/nvim-autopairs"),
    gh("echasnovski/mini.surround"),
    gh("jake-stewart/multicursor.nvim", { name = "multicursor.nvim", version = "1.0" }),
    gh("folke/which-key.nvim"),
    gh("valonmulolli/zignite.nvim", { name = "zignite.nvim" }),
    gh("valonmulolli/heap.nvim", { name = "heap-nvim" }),
    gh("valonmulolli/retroline.nvim"),
    gh("mbbill/undotree", { name = "undotree" }),
  },

  modules = {
    "plugins.heap",
    "plugins.retroline",
    "plugins.snacks",
    "plugins.which-key",
    "plugins.blink",
    "plugins.snippets",
    "plugins.treesitter",
    "plugins.utils",
    "plugins.git",
    "plugins.flash",
    "plugins.session",
    "plugins.todo-comments",
    "plugins.conform",
    "plugins.database",
    "plugins.markdown",
    "plugins.love",
    "plugins.typespreview",
    "plugins.lspconfig",
    "plugins.typescript-tools",
    "plugins.neocodeium",
    "plugins.dap",
    "plugins.sidekick",
    "plugins.undotree",
    "plugins.zignite",
  },

  builds = {
    ["markdown-preview.nvim"] = "cd app && bun install",
    ["nvim-treesitter"] = ":TSUpdate",
    ["zignite.nvim"] = build_zignite,
  },
}

local local_plugins = {}

local function prefer_local(name, path, build)
  if not path or vim.fn.isdirectory(path) ~= 1 then
    return
  end

  for index, spec in ipairs(registry.remote) do
    if spec.name == name then
      table.remove(registry.remote, index)
      break
    end
  end

  local_plugins[#local_plugins + 1] = {
    name = name,
    path = path,
    build = build,
  }
end

prefer_local("zignite.nvim", paths.plugins.zignite, build_zignite)
prefer_local("heap-nvim", paths.plugins.heap)
prefer_local("retroline.nvim", paths.plugins.retroline)

if #local_plugins > 0 then
  registry.local_plugins = local_plugins
end

return registry
