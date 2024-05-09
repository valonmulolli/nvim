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
		"Yazeed1s/minimal.nvim",
		lazy = false,
		colorscheme = "minimal",
		-- opts = {
		--   minimal_transparent_background = false,
		--   styles = {
		--     sidebars = "transparent",
		--     floats = "transparent",
		--   },
		-- },
		branch = "main",
		priority = 1000,
		config = function()
			-- vim.cmd("colorscheme colorscheme minimal")
		end,
	},
	{
		"lighthaus-theme/vim-lighthaus",
		lazy = false,
		opts = {
			transparent = true,
			italic = true,
		},
		priority = 1000,
		config = function()
			-- vim.cmd("colorscheme lighthaus")
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
			vim.cmd("colorscheme oldworld")
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
		"srcery-colors/srcery-vim",
		colorscheme = "srcery",
		lazy = false,
		priority = 1000,
		config = function()
			-- vim.cmd("colorscheme srcery")
		end,
	},
	{
		"m15a/nvim-srcerite",
		colorscheme = "srcerite",
		lazy = false,
		priority = 1000,
		config = function()
			-- vim.cmd("colorscheme srcerite")
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
		"datsfilipe/min-theme.nvim",
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
			-- vim.cmd("colorscheme min-themey")
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
