local M = {}

function M.setup()
  ---@type retroline.Config
  local opts = {
    animation = "orbit",
    mode = {
      style = "short",
      animate = true,
      animation = "retro_cursor",
      separator = " ",
    },
    path = {
      style = "relative",
      keep_segments = 2,
      max_length = 56,
    },
    diagnostic = {
      style = "compact",
      animate = true,
      animate_severities = { "ERROR" },
      animation = "retro_alarm",
      show_zero = false,
      empty = "OK",
    },
    statusline = {
      style = "rounded",
      retro = true,
      transparent = true,
      adaptive = true,
      compact_width = 108,
      minimal_width = 82,
      show_filetype = false,
      show_flags = true,
      show_git = true,
      show_lsp = true,
      show_location = true,
      show_progress = true,
      pad = " ",
    },
    performance = {
      idle_timeout = 1200,
    },
  }

  ---@type retroline.Module
  local retroline = require("retroline")
  retroline.setup(opts)
  retroline.enable_statusline()
end

return M
