return {
  "lukas-reineke/indent-blankline.nvim",
  enabled = true,
  config = function()
  --   local hl_list = {}
  --   -- hide first level line by color (#1E1E2E)
  --   local c = '#2A2B3C'
  --   for i, color in pairs({ '#1E1E2E', c, c, c, c, c, c, c, c, c, c, c, c, c }) do
  --     local name = 'IndentBlanklineIndent' .. i
  --     vim.api.nvim_set_hl(0, name, { fg = color, bg = color })
  --     table.insert(hl_list, name);
  --   end
  --   require('indent_blankline').setup {
  --     char_highlight_list = hl_list,
  --   }
  end,
}
