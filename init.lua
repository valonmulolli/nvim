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

vim.cmd.colorscheme("visual_studio_code")
vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim/bin/python3")
vim.g.loaded_python3_provider = nil
vim.cmd("runtime! plugin/rplugin.vim")
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua"
