local M = {}

function M.setup()
  require("heap").setup({
    transparent_background = true,
    tweak_background = {
      menu = "none",
      telescope = "none",
      nvimtree = "none",
      neotree = "none",
    },
    plugins = {
      blink = true,
      telescope = true,
      nvim_tree = true,
      snacks = true,
      lualine = false,
    },
  })
end

return M
