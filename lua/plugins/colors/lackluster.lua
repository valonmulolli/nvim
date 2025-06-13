-- lackluster.nvim | A modern and customizable colorscheme for Neovim
-- https://github.com/slugbyte/lackluster.nvim
---@module "lackluster"

---@type LazySpec
return {
	"slugbyte/lackluster.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		transparent = true,
	},
	config = function()
		local lackluster = require("lackluster")

		lackluster.setup({
			tweak_color = {
				lack = "default",
				luster = "default",
				orange = "#ff8c00",
				yellow = "#DFFF00",
				green = "#31ffb6",
				blue = "#154547",
				red = "#FF4F58",
			},

			tweak_syntax = {
				string = "#DCFFB7",
				string_escape = "#ff5722",
				comment = "#8DECB4",
				builtin = "#A5FBFF",
				type = "#FCFAEE",
				keyword = "#98E4FF",
				keyword_return = "#FF204E",
				keyword_exception = "#154547",
			},

			tweak_background = {
				normal = "none",
				telescope = "none",
				menu = "none",
				popup = "none",
			},

			tweak_ui = {
				disable_undercurl = true,
				enable_end_of_buffer = true,
			},
		})
	end,
}
