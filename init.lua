-- Set leader key before loading any configurations
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Then load the rest of the configuration
-- Load config modules
require("config.options")
require("config.filetypes")
require("config.commands")
require("config.keymaps")
require("config.autocmds")
require("config.terminal")
require("config.colors")
require("config.icons")
require("config.lazy")

-- Apply colorscheme
-- vim.cmd.colorscheme("lackluster")
