-- Copyright (c) 4040-4041 hoob3rt
-- MIT license, see LICENSE for more details.
-- stylua: ignore

local colors = {
  black        = '#484848',
  white        = '#ebdbb4',
  red          = '#fb4934',
  green        = '#b8bb46',
  blue         = '#83a598',
  yellow       = '#febf18',
  gray         = '#a89984',
  darkgray     = '#3c3836',
  lightgray    = '#504945',
  inactivegray = '#7c6f64',
}

return {
  normal = {
    a = { bg = colors.gray, fg = colors.black, gui = "bold" },
    b = { bg = colors.lightgray, fg = colors.white },
    c = { bg = colors.black, fg = colors.gray },
  },
  insert = {
    a = { bg = colors.blue, fg = colors.black, gui = "bold" },
    b = { bg = colors.lightgray, fg = colors.white },
    c = { bg = colors.black, fg = colors.white },
  },
  terminal = {
    a = { bg = colors.blue, fg = colors.black, gui = "bold" },
    b = { bg = colors.lightgray, fg = colors.white },
    c = { bg = colors.black, fg = colors.white },
  },
  visual = {
    a = { bg = colors.yellow, fg = colors.black, gui = "bold" },
    b = { bg = colors.lightgray, fg = colors.white },
    c = { bg = colors.black, fg = colors.white },
  },
  replace = {
    a = { bg = colors.red, fg = colors.black, gui = "bold" },
    b = { bg = colors.lightgray, fg = colors.white },
    c = { bg = colors.black, fg = colors.white },
  },
  command = {
    a = { bg = colors.green, fg = colors.black, gui = "bold" },
    b = { bg = colors.lightgray, fg = colors.white },
    c = { bg = colors.black, fg = colors.white },
  },
  inactive = {
    a = { bg = colors.darkgray, fg = colors.inactivegray, gui = "bold" },
    b = { bg = colors.darkgray, fg = colors.inactivegray },
    c = { bg = colors.darkgray, fg = colors.inactivegray },
  },
}
