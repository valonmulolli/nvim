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
		  blue = "#005F87",
		  red = "#FF4F58",
		},
  
		tweak_syntax = {
		  string = "#DCFFB7",
		  string_escape = "#ff5722",
		  comment = "#8DECB4",
		  builtin = "#96A6C8",
		  type = "#FCFAEE",
		  keyword = "#98E4FF",
		  keyword_return = "#FF204E",
		  keyword_exception = "#40A2E3",
		},
  
		tweak_background = {
		  normal = "none",
		  telescope = "default",
		  menu = "default", 
		  popup = "default",
		},
  
		tweak_ui = {
		  disable_undercurl = true,
		  enable_end_of_buffer = true,
		},
	  })
  
	end,
  }