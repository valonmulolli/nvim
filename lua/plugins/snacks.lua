return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	config = function()
		local map = vim.keymap.set
		local snacks = require("snacks")
		snacks.setup({
			-- ====================
			-- dashboard setup
			-- ====================
			dashboard = {
				enabled = true,
				preset = {
					header = [[
.--------------------------------------------.
|██╗   ██╗██╗  ██╗███████╗ ██████╗ ███╗   ██╗|
|██║   ██║██║  ██║╚════██║██╔═████╗████╗  ██║|
|██║   ██║███████║    ██╔╝██║██╔██║██╔██╗ ██║|
|╚██╗ ██╔╝╚════██║   ██╔╝ ████╔╝██║██║╚██╗██║|
| ╚████╔╝      ██║   ██║  ╚██████╔╝██║ ╚████║|
|  ╚═══╝       ╚═╝   ╚═╝   ╚═════╝ ╚═╝  ╚═══╝|
'--------------------------------------------'
        ]],
					keys = {
						{ key = "SPC o", desc = "Options" },
						{ key = "SPC f", desc = "Fuzzy Find" },
						{ key = "SPC s", desc = "Session" },
						{ key = "SPC b", desc = "Buffers" },
						{ key = "SPC e", desc = "Filetree" },
						{ key = "SPC l", desc = "LSP" },
						{ key = "SPC p", desc = "Window" },
						{ key = "SPC g", desc = "Gitsigns" },
						{ key = "SPC c", desc = "Snacks" },
						{ key = "SPC n", desc = "Noice" },
					},
				},
				formats = {
					footer = { "%s", align = "center" },
					header = { "%s", align = "center" },
				},
			}, -- dashboard ends

			-- ====================
			-- Notifications setup
			-- ====================
			notifier = {
				enabled = true,
				timeout = 2000,
				style = "compact",
				width = { min = 35, max = 0.8 },
				height = { min = 1, max = 0.8 },
			}, -- notifier ends

			-- ====================
			-- Indent setup
			-- ====================
			indent = {
				enabled = true,
				animate = {
					enabled = false,
				},
				scope = {
					enabled = false,
				},

				-- can be a list of hl groups to cycle through
				indent = {
					hl = {
						"SnacksIndent1",
						"SnacksIndent2",
						"SnacksIndent3",
						"SnacksIndent4",
						"SnacksIndent5",
						"SnacksIndent6",
						"SnacksIndent7",
					},
				},
			},
			picker = {
				enabled = true,
				prompt = "> ",
				ui_select = true,
				formatters = {
					file = {
						filename_first = true,
						truncate = 100, -- truncate the file path to (roughly) this length
					},
				},
				layouts = {
					default = {
						layout = {
							box = "horizontal",
							width = 0.90,
							height = 0.90,
							{
								box = "vertical",
								border = "rounded",
								title = "{source} {live}",
								title_pos = "center",
								{ win = "input", height = 1, border = "bottom" },
								{ win = "list", border = "none" },
							},
							{ win = "preview", title = "{preview}", border = "rounded", width = 0.5 },
						},
					},
				},
				win = {
					-- input window
					input = {
						keys = {
							["<C-h>"] = { "toggle_hidden", mode = { "i", "n" } },
							["<Esc>"] = { "close", mode = { "i", "n" } },
							["<C-\\>"] = { "toggle_preview", mode = { "i", "n" } },
						},
					},
				},
			},
			bigfile = {
				enabled = true,
			},
			lazygit = {
				enabled = false,
			},
			terminal = {
				enabled = false,
			},
			dim = {
				enabled = false,
			},
			zen = {
				enabled = false,
			},
			input = {
				enabled = true,
			},
			quickfile = {
				enabled = false,
			},
			scroll = {
				enabled = false,
			},
			statuscolumn = {
				enabled = false,
			},
			words = {
				enabled = false,
			},
			layout = {
				enabled = false,
			},
			debug = {
				enabled = false,
			},
		})

		-- keymaps
		map("n", "<leader>e", ':lua require("snacks").explorer()<cr>', { desc = "File Explorer", noremap = true, silent = true })
		map(
			"n",
			"<leader>cn",
			':lua require("snacks").notifier.show_history()<cr>',
			{ desc = "Notifications", noremap = true, silent = true }
		)

	end,
}
