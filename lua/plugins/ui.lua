return {
  -- messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })

      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })

      opts.presets.lsp_doc_border = true
    end,
  },

  -- notifications

  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        stages = "fade_in_slide_out",
        background_colour = "FloatShadow",
        timeout = 3000,
        render = "compact",
        top_down = false,
      })
      vim.notify = require("notify")
    end,
  },
  -- animations
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.scroll = {
        enable = false,
      }
    end,
  },

  -- buffer line
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>nt", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<leader>np", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = {
      options = {
        mode = "tabs",
        -- separator_style = "slant",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },

  -- statusline
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   dependencies = { "raphamorim/vim-rio" },
  --   event = "VeryLazy",
  --   opts = {
  --     options = {
  --       -- globalstatus = false,
  --       theme = "auto",
  --     },
  --   },
  -- },

  -- filename
  {
    "b0o/incline.nvim",
    dependencies = { "raphamorim/vim-rio" },
    event = "BufReadPre",
    priority = 1200,
    config = function()
      require("incline").setup({
        highlight = {
          -- groups = {
          -- 	InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
          -- 	InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
          -- },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end

          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        kitty = { enabled = false, font = "+2" },
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function(_, opts)
      local logo = [[

██╗   ██╗██╗  ██╗███████╗ ██████╗ ███╗   ██╗
██║   ██║██║  ██║╚════██║██╔═══██╗████╗  ██║
██║   ██║███████║    ██╔╝██║   ██║██╔██╗ ██║
╚██╗ ██╔╝╚════██║   ██╔╝ ██║   ██║██║╚██╗██║
 ╚████╔╝      ██║   ██║  ╚██████╔╝██║ ╚████║
  ╚═══╝       ╚═╝   ╚═╝   ╚═════╝ ╚═╝  ╚═══╝
				
      ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
    end,
  },
}
