-- Neovim/Vim color scheme inspired by Dark+ and Light+
-- https://github.com/Mofiqul/vscode.nvim

---@type LazyPluginSpec
return {
  "Mofiqul/vscode.nvim",
  lazy = false,
  priority = 1000,
  opts = function()
    local c = require("vscode.colors").get_colors()
    return {
      style = "dark",
      transparent = true,
      italic_comments = false,
      disable_nvimtree_bg = true,
      color_overrides = {
        vscFoldBackground = "#444444",
      },
      group_overrides = {
        -- General
        NormalFloat = { link = "Normal" },
        FloatBorder = { fg = "#5A5A5A", bg = "none" },
        ColorColumn = { bg = "#0f0f0f" },
        CurSearch = { link = "IncSearch" },
        CursorLine = { bg = "Gray8" },
        CursorLineNr = { link = "Number" },
        EndOfBuffer = { fg = "#444444" },
        MsgSeparator = { link = "VertSplit" },
        SpecialChar = { fg = c.vscBlue },

        -- Git status
        DiffAdd = { bg = "#414D19", fg = "none" },
        DiffChange = { bg = "#3B3814", fg = "none" },
        DiffDelete = { bg = "none", fg = "indianred" },

        -- Diagnostic
        DiagnosticVirtualTextError = { bg = c.vscBack, fg = c.vscRed },
        DiagnosticVirtualTextWarn = { bg = c.vscBack, fg = c.vscYellow },
        DiagnosticVirtualTextInfo = { bg = c.vscBack, fg = c.vscBlue },
        DiagnosticVirtualTextHint = { bg = c.vscBack, fg = c.vscWhite },

        -- LSP
        LspCodeLens = { link = "LineNr" },
        LspFloatWinNormal = { link = "NormalFloat" },
        LspInfoBorder = { link = "FloatBorder" },

        -- Treesitter Rainbow | Treesitter/Indent-Blankline
        RainbowDelimiterBlue = { fg = c.vscBlue, nocombine = true },
        RainbowDelimiterCyan = { fg = c.vscBlueGreen, nocombine = true },
        RainbowDelimiterGreen = { fg = c.vscGreen, nocombine = true },
        RainbowDelimiterOrange = { fg = c.vscOrange, nocombine = true },
        RainbowDelimiterPink = { fg = c.vscPink, nocombine = true },
        RainbowDelimiterRed = { fg = c.vscRed, nocombine = true },
        RainbowDelimiterViolet = { fg = c.vscViolet, nocombine = true },
        RainbowDelimiterYellow = { fg = c.vscYellow, nocombine = true },

        -- Whichkey
        WhichKeyFloat = { link = "StatusLineNC" },
      },
    }
  end,
}
