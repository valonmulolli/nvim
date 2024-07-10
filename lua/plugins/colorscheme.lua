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
			vim.cmd("colorscheme vscode"),
		}
	end,
	{
		"ellisonleao/gruvbox.nvim",
		event = { "ColorSchemePre" },
		opts = {
			contrast = "hard", -- can be "hard", "soft" or empty string
			inverse = false, -- invert background for search, diffs, statusline and errors
			transparent_mode = true,
			bold = false,
			italic = {
				comments = false,
				folds = false,
				operators = false,
				strings = false,
			},
			palette_overrides = {},
			overrides = {
				-- General
				CursorLineNr = { bg = "none" },
				ErrorMsg = { link = "Error" },
				FloatBorder = { bg = "none", fg = "#756a60" },
				MsgSeparator = { link = "VertSplit" },

				-- Telescope
				TelescopeBorder = { link = "FloatBorder" },
				TelescopePromptBorder = { link = "FloatBorder" },
				TelescopePreviewBorder = { link = "FloatBorder" },
			},
		},
	},
	{
		"metalelf0/jellybeans-nvim",
		dependencies = { "rktjmp/lush.nvim" },
		colorscheme = "jellybeans-nvim",
		lazy = false,
		opts = {
			italic = false,
		},
		priority = 1000,
		config = function()
			-- vim.cmd('colorscheme jellybeans-nvim')
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
			-- vim.cmd("colorscheme oh-lucy-evening")
		end,
	},
	{
		"dgox16/oldworld.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			opts = {
				styles = {
					transparent = true,
					italic_comments = true,
					bold = true,
					hide_fillchars = true,
					borderless_telescope = true,
				},
			}
			-- vim.cmd("colorscheme oldworld")
		end,
	},
	{
		"sekke276/dark_flat.nvim",
		lazy = false,
		opts = {
			transparent = true,
			italic = true,
		},
		priority = 1000,
		config = function()
			-- vim.cmd.colorscheme("dark_flat")
		end,
	},
	{
		"kepano/flexoki-neovim",
		lazy = false,
		opts = {
			transparent = true,
			italic = true,
		},
		priority = 1000,
		config = function()
			-- vim.cmd.colorscheme("flexoki-dark")
		end,
	},
	{
		"DeviusVim/deviuspro.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			-- vim.cmd("colorscheme deviuspro")
		end,
	},
	{
		"davidosomething/vim-colors-meh",
		colorscheme = "meh",
		lazy = false,
		priority = 1000,
		config = function()
			-- vim.cmd("colorscheme meh")
		end,
	},
	{
		"ntk148v/komau.vim",
		colorscheme = "komau",
		lazy = false,
		priority = 1000,
		config = function()
			-- vim.cmd("colorscheme komau")
		end,
	},
	{
		"danishprakash/vim-yami",
		colorscheme = "yami",
		lazy = false,
		priority = 1000,
		config = function()
			-- vim.cmd("colorscheme yami")
		end,
	},
	{
		"kvrohit/rasmus.nvim",
		colorscheme = "rasmus",
		lazy = false,
		priority = 1000,
		config = function()
			-- vim.cmd("colorscheme rasmus")
		end,
	},
	{
		"fxn/vim-monochrome",
		colorscheme = "monochrome",
		lazy = false,
		priority = 1000,
		config = function()
			-- vim.cmd("colorscheme monochrome")
		end,
	},
	{
		"andreypopp/vim-colors-plain",
		colorscheme = "plain",
		lazy = false,
		priority = 1000,
		config = function()
			-- vim.cmd("colorscheme plain")
		end,
	},
 {
		"nikolvs/vim-sunbather",
		colorscheme = "sunbather",
		lazy = false,
		priority = 1000,
		config = function()
			-- vim.cmd("colorscheme sunbather")
		end,
	},
	{
		"raphamorim/vim-rio",
		-- lazy = false,
		colorscheme = "rio",
		opts = {
			transparent = true,
			italic = true,
		},
		branch = "main",
		priority = 1000,
		config = function()
			-- vim.cmd("colorscheme rio")
		end,
	},
	{
		"datsfilipe/vesper.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			opts = {
				styles = {
					transparent = true,
					italic_comments = true,
					hide_fillchars = true,
					borderless_telescope = true,
				},
			}
			-- vim.cmd("colorscheme vesper")
		end,
	},
	{
		"widatama/vim-phoenix",
		lazy = false,
		priority = 1000,
		config = function()
			opts = {
				styles = {
					transparent = true,
					italic_comments = true,
					hide_fillchars = true,
					borderless_telescope = true,
				},
			}
			-- vim.cmd("colorscheme phoenix")
		end,
	},
	{
		"woife5/windows.nvim",
		config = function()
			-- Activation
			-- vim.cmd([[colorscheme windows-xp]])
		end,
	},
	{
		"Abstract-IDE/Abstract-cs",
		config = function()
			-- vim.cmd [[colorscheme abscs]]
		end,
	},
	{
		"nocksock/nazgul-vim",
		config = function()
			-- vim.cmd([[colorscheme nazgul]])
		end,
	},
	{
		"slugbyte/lackluster.nvim",
		lazy = false,
		priority = 1000,
		init = function()
			-- vim.cmd.colorscheme("lackluster")
			-- vim.cmd.colorscheme("lackluster-night")
			vim.cmd.colorscheme("lackluster-mint")
			-- vim.cmd.colorscheme("lackluster-dark")
		end,
	},
	{
		"aktersnurra/no-clown-fiesta.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			opts = {
				styles = {
					transparent = true,
					italic_comments = true,
					hide_fillchars = true,
					borderless_telescope = true,
				},
			}
			-- vim.cmd([[colorscheme no-clown-fiesta]])
		end,
	},
	{
		"DanielEliasib/sweet-fusion",
		lazy = false,
		priority = 1000,
		config = function()
			opts = {
				styles = {
					transparent = true,
					italic_comments = true,
					hide_fillchars = true,
					borderless_telescope = true,
				},
			}
			-- vim.cmd [[colorscheme sweet-fusion]]
		end,
	},
}
