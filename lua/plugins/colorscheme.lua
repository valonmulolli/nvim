return {
  "Mofiqul/vscode.nvim",
  lazy = true,
  priority = 1000,
  opts = function()
    return {
      style = "dark",
      transparent = false,
      italic_comments = false,
      disable_nvimtree_bg = true,
      color_overrides = {
        vscFoldBackground = "#242424",
      },
      group_overrides = {
        -- General
        NormalFloat = { link = "Normal" },
        FloatBorder = { fg = "#5A5A5A", bg = "none" },
        ColorColumn = { bg = "#0f0f0f" },
        CurSearch = { link = "IncSearch" },
        CursorLineNr = { link = "Number" },
        EndOfBuffer = { fg = "#222222" },
        MsgSeparator = { link = "VertSplit" },

        -- Git status
        DiffAdd = { bg = "#212D19", fg = "none" },
        DiffChange = { bg = "#3B3814", fg = "none" },
        DiffDelete = { bg = "none", fg = "indianred" },

        -- LSP
        LspCodeLens = { link = "LineNr" },
        LspFloatWinNormal = { link = "NormalFloat" },
        LspInfoBorder = { link = "FloatBorder" },
      },
    }
  end,
}
