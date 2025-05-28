-- Copyright (c) 2023 v470n
-- MIT license, see LICENSE for more details.
-- Lackluster theme for lualine

local colors = {
    lack    = '#98E4FF',   -- main accent color
    luster  = '#1398b9',   -- secondary accent
    bg      = 'none',      -- transparent background
    fg      = '#FCFAEE',   -- type color as foreground
    red     = '#FF4F58',
    green   = '#31ffb6',
    blue    = '#005F87',
    yellow  = '#DFFF00',
    orange  = '#ff8c00',
    string  = '#DCFFB7',
    comment = '#8DECB4',
    builtin = 'none',
}

return {
    normal = {
        a = { bg = colors.lack, fg = colors.bg, gui = 'bold' },
        b = { bg = colors.builtin, fg = colors.bg },
        c = { bg = colors.bg, fg = colors.fg }
    },
    insert = {
        a = { bg = colors.luster, fg = colors.bg, gui = 'bold' },
        b = { bg = colors.builtin, fg = colors.bg },
        c = { bg = colors.bg, fg = colors.fg }
    },
    visual = {
        a = { bg = colors.yellow, fg = colors.bg, gui = 'bold' },
        b = { bg = colors.builtin, fg = colors.bg },
        c = { bg = colors.bg, fg = colors.fg }
    },
    replace = {
        a = { bg = colors.red, fg = colors.bg, gui = 'bold' },
        b = { bg = colors.builtin, fg = colors.bg },
        c = { bg = colors.bg, fg = colors.fg }
    },
    command = {
        a = { bg = colors.green, fg = colors.bg, gui = 'bold' },
        b = { bg = colors.builtin, fg = colors.bg },
        c = { bg = colors.bg, fg = colors.fg }
    },
    inactive = {
        a = { bg = colors.bg, fg = colors.comment, gui = 'bold' },
        b = { bg = colors.bg, fg = colors.comment },
        c = { bg = colors.bg, fg = colors.comment }
    }
}
