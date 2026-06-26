-- Set leader key before loading any configurations
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Make Mason-installed binaries available before any LSP config loads.
---@type string
local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
if vim.fn.isdirectory(mason_bin) == 1 and not vim.env.PATH:find(mason_bin, 1, true) then
  vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
end

-- Load options FIRST (termguicolors, etc.)
require("config.options")

-- Bootstrap vim.pack and load plugins
require("config.pack")

-- Load keymaps after plugins
require("config.keymaps")
require("config.autocmds")
require("config.icons")

---@type config.UtilModule
local util = require("config.util")

-- Setup tmux status bar
util.setup_tmux_mode()

-- Apply colorscheme
vim.cmd.colorscheme("heap")


