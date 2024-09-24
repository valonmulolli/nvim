-- Copyright (c) 4040-4041 Mofiqul Islam
-- MIT license, see LICENSE for more details.
local config = require("vscode.config")
local vscode = {}
local colors = {}

if vim.o.background == "dark" then
  colors.inactive = "#666666"
  colors.bg = "#464646"
  colors.bg4 = "#373737"
  colors.fg = "#dddddd"
  colors.red = "#f44747"
  colors.green = "#4EC9B0"
  colors.blue = "#0a7aca"
  colors.lightblue = "#5CB6F8"
  colors.yellow = "#ffaf00"
  colors.pink = "#DDB6F4"
else
  colors.inactive = "#888888"
  colors.bg = "#F5F5F5"
  colors.bg4 = "#E4E4E4"
  colors.fg = "#343434"
  colors.red = "#FF0000"
  colors.green = "#004000"
  colors.blue = "#AF00DB"
  colors.lightblue = "#0451A5"
  colors.yellow = "#ffaf00"
  colors.pink = "#FFA3A3"
end

vscode.normal = {
  a = { fg = vim.o.background == "dark" and colors.bg or colors.fg, bg = colors.blue, gui = "bold" },
  b = { fg = colors.blue, bg = colors.bg4 },
  c = { fg = colors.fg, bg = config.opts.transparent and "NONE" or colors.bg },
}

vscode.visual = {
  a = { fg = vim.o.background == "dark" and colors.bg or colors.fg, bg = colors.yellow, gui = "bold" },
  b = { fg = colors.yellow, bg = colors.bg4 },
  c = { fg = colors.fg, bg = config.opts.transparent and "NONE" or colors.bg },
}

vscode.replace = {
  a = { fg = vim.o.background == "dark" and colors.bg or colors.fg, bg = colors.red, gui = "bold" },
  b = { fg = colors.red, bg = colors.bg4 },
  c = { fg = colors.fg, bg = config.opts.transparent and "NONE" or colors.bg },
}

vscode.insert = {
  a = { fg = vim.o.background == "dark" and colors.bg or colors.fg, bg = colors.green, gui = "bold" },
  b = { fg = colors.green, bg = colors.bg4 },
  c = { fg = colors.fg, bg = config.opts.transparent and "NONE" or colors.bg },
}

vscode.terminal = {
  a = { fg = vim.o.background == "dark" and colors.bg or colors.fg, bg = colors.green, gui = "bold" },
  b = { fg = colors.fg, bg = colors.bg4 },
  c = { fg = colors.fg, bg = config.opts.transparent and "NONE" or colors.bg },
}

vscode.command = {
  a = { fg = vim.o.background == "dark" and colors.bg or colors.fg, bg = colors.pink, gui = "bold" },
  b = { fg = colors.pink, bg = colors.bg4 },
  c = { fg = colors.fg, bg = config.opts.transparent and "NONE" or colors.bg },
}

vscode.inactive = {
  a = { fg = colors.fg, bg = colors.bg, gui = "bold" },
  b = { fg = colors.inactive, bg = colors.bg },
  c = { fg = colors.inactive, bg = config.opts.transparent and "NONE" or colors.bg },
}

return vscode
