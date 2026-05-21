local M = {}

function M.setup()
  require("typst-preview").setup({
    invert_colors = "always",
  })
end

return M
