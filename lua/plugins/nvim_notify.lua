return {
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		config = function()
			local notify = require("notify")

			-- Set the notify function globally for other plugins to use
			vim.notify = notify

			-- Setup nvim-notify with custom options
			notify.setup({
				background_colour = "#282828", -- Dark background for notifications
				timeout = 300, -- Duration for notifications
				fps = 60, -- Frames per second for animations
				icons = {
					DEBUG = "🐞", -- Custom icon for DEBUG
					ERROR = "❌", -- Custom icon for ERROR
					INFO = "ℹ️", -- Custom icon for INFO
					TRACE = "🔍", -- Custom icon for TRACE
					WARN = "⚠️", -- Custom icon for WARN
				},
				level = 2, -- Minimum log level to display
				stages = "fade_in_slide_out", -- Animation stages
				render = "default", -- Use default rendering style
			})

			-- Viewing history with Telescope
			if pcall(require, "telescope") then
				require("telescope").load_extension("notify")
			end
		end,
	},
}
