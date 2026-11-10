local M = {}

function M.setup()
  require("heap").setup({
    transparent_background = true,
    plugins = {
      blink = true,
      telescope = true,
      snacks = true,
    },
  })
end

return M
