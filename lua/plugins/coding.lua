return {
  -- Create annotations with one keybind, and jump your cursor in the inserted annotation
  {
    "danymat/neogen",
    keys = {
      {
        "<leader>cc",
        function()
          require("neogen").generate({})
        end,
        desc = "Neogen Comment",
      },
    },
    opts = { snippet_engine = "luasnip" },
  },

  -- Incremental rename
  -- {
  --   "smjonas/inc-rename.nvim",
  --   cmd = "IncRename",
  --   config = true,
  -- },
  {
    { "barrett-ruth/live-server.nvim", config = true },
  },

  -- Refactoring tool
  {
    "ThePrimeagen/refactoring.nvim",
    keys = {
      {
        "<leader>re",
        function()
          require("refactoring").select_refactor()
        end,
        mode = "v",
        noremap = true,
        silent = true,
        expr = false,
      },
    },
    opts = {},
  },
  {
    "jose-elias-alvarez/typescript.nvim",
    ft = { "typescript", "typescriptreact", "typescript.tsx" },
    keys = {
      { "<leader>lR", vim.cmd.TypescriptRenameFile,        desc = "" },
      { "<leader>oi", vim.cmd.TypescriptOrganizeImports,   desc = "" },
      { "<leader>ai", vim.cmd.TypescriptAddMissingImports, desc = "" },
      { "<leader>ru", vim.cmd.TypescriptRemoveUnused,      desc = "" },
    },
    opts = {
      server = {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      },
    },
  },
  -- Go forward/backward with square brackets
  {
    "echasnovski/mini.bracketed",
    event = "BufReadPost",
    config = function()
      local bracketed = require("mini.bracketed")
      bracketed.setup({
        file = { suffix = "" },
        window = { suffix = "" },
        quickfix = { suffix = "" },
        yank = { suffix = "" },
        treesitter = { suffix = "n" },
      })
    end,
  },
  -- Better increase/descrease
  {
    "monaqa/dial.nvim",
    -- stylua: ignore
    keys = {
      { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
      { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
          augend.constant.new({ elements = { "let", "const" } }),
        },
      })
    end,
  },
  {
    'barrett-ruth/live-server.nvim',
    build = 'pnpm add -g live-server',
    cmd = { 'LiveServerStart', 'LiveServerStop' },
    config = true,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  {
    "szw/vim-maximizer",
  },
  {
    "simrat39/symbols-outline.nvim",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    cmd = "SymbolsOutline",
    opts = {
      position = "right",
    },
  },
  {
    "nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },
  {
    "Exafunction/codeium.vim",
    cmd = "Codeium",
    opts = {
      opts = function(_, opts)
        table.insert(opts.sources, 5, {
          name = "codeium",
          group_index = 5,
          priority = 104,
        })
      end,
    },
    event = "BufEnter",
    config = function()
      vim.keymap.set("i", '<C-e>', function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, silent = true })
      vim.api.nvim_set_keymap("i", "<C-g>", "<Cmd>call codeium#CycleCompletions(5)<CR>",
        { silent = true })
      vim.api.nvim_set_keymap("i", "<C-,>", "<Cmd>call codeium#CycleCompletions(3)<CR>",
        { silent = true })
      vim.api.nvim_set_keymap("i", "<C-x>", "<Cmd>call codeium#Clear()<CR>", { silent = true })
    end,
  },

  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  {
    "David-Kunz/gen.nvim",
  },
  {
    "wintermute-cell/gitignore.nvim",
    config = function()
      require("gitignore")
    end,
  },
  -- {
  --   "abecodes/tabout.nvim",
  --   config = function()
  --     require("tabout").setup({
  --       tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
  --       backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
  --       act_as_tab = true, -- shift content if tab out is not possible
  --       act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
  --       default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
  --       default_shift_tab = "<C-d>", -- reverse shift default action,
  --       enable_backwards = true, -- well ...
  --       completion = true, -- if the tabkey is used in a completion pum
  --       tabouts = {
  --         { open = "'", close = "'" },
  --         { open = '"', close = '"' },
  --         { open = "`", close = "`" },
  --         { open = "(", close = ")" },
  --         { open = "[", close = "]" },
  --         { open = "{", close = "}" },
  --       },
  --       ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
  --       exclude = {}, -- tabout will ignore these filetypes
  --     })
  --   end,
  --   wants = { "nvim-treesitter" }, -- or require if not used so far
  --   after = { "nvim-cmp" }, -- if a completion plugin is using tabs load it before
  -- },
}
