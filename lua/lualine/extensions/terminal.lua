local M = {}

M.sections = {
  lualine_a = {
    {
      "mode",
      fmt = function(str)
        return str:sub(1, 1)
      end,
    },
  },
  lualine_c = { "filename" },
  lualine_x = { "searchcount" },
  lualine_z = { "location" },
}

M.filetypes = {
  "floaterm",
  "neoterm",
  "terminal",
  "toggleterm",
}

return M
