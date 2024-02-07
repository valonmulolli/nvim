return {
  "Mofiqul/vscode.nvim",
  lazy = true,
  priority = 1000,
  opts = function()
    return {
      style = "dark",
      transparent = true,
      italic_comments = false,
      disable_nvimtree_bg = true,
      color_overrides = {
        vscFoldBackground = "#070707",
      },
      group_overrides = {
        -- General
        NormalFloat = { link = "Normal" },
        FloatBorder = { fg = "#5A5A5A", bg = "none" },
        ColorColumn = { bg = "#0f0f0f" },
        CurSearch = { link = "IncSearch" },
        CursorLineNr = { link = "Number" },
        EndOfBuffer = { fg = "#222222" },
        MsgSeparator = { link = "VertSplit" },

        -- Git status
        DiffAdd = { bg = "#212D19", fg = "none" },
        DiffChange = { bg = "#3B3814", fg = "none" },
        DiffDelete = { bg = "none", fg = "indianred" },

        -- LSP
        LspCodeLens = { link = "LineNr" },
        LspFloatWinNormal = { link = "NormalFloat" },
        LspInfoBorder = { link = "FloatBorder" },
      },
      -- vim.cmd("colorscheme vscode"),
    }
  end,
  {
    "metalelf0/jellybeans-nvim",
    dependencies = { "rktjmp/lush.nvim" },
    colorscheme = "jellybeans-nvim",
    lazy = true,
    priority = 1000,
    opts = function()
      return {
        transparent = true,
        disable_italic = false,
        color_overrides = {
          vscFoldBackground = "#070707",
        },
        -- vim.cmd("colorscheme arctic"),
      }
    end,
  },
  {
    "zootedb0t/citruszest.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("citruszest").setup({
        option = {
          transparent = true,
          bold = false,
          italic = false,
        },
        style = {
          Constant = { fg = "#FFFFFF", bold = true },
        },
      })
    end,
    init = function()
      -- vim.cmd("colorscheme citruszest")
    end,
  },
  {
    "nocksock/bloop.nvim",
    dependencies = { "rktjmp/lush.nvim" },
    lazy = false,
    colorscheme = "bloop",
    branch = "main",
    priority = 1000,
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
    config = function()
      -- vim.cmd("colorscheme bloop")
    end,
  },
  {
    "Yazeed1s/oh-lucy.nvim",
    lazy = false,
    colorscheme = "oh-lucy",
    branch = "main",
    priority = 1000,
    opts = {
      transparent_background = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
    config = function()
      vim.cmd("colorscheme oh-lucy-evening")
    end,
  },
  {
    "Yazeed1s/minimal.nvim",
    lazy = false,
    colorscheme = "minimal",
    opts = {
      minimal_transparent_background = false,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
    branch = "main",
    priority = 1000,
    config = function()
      -- vim.cmd("colorscheme colorscheme minimal")
    end,
  },
  {
    "raphamorim/vim-rio",
    -- lazy = false,
    colorscheme = "rio",
    opts = {
      transparent_background = true,
    },  
    branch = "main",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme rio")
    end,
  },
}
