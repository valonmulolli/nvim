local M = {}

M.keys = {
  { "<leader>li", ft = "lua", desc = "LÖVE" },
  { "<leader>ll", "<cmd>LoveRun<cr>", ft = "lua", desc = "Run LÖVE" },
  { "<leader>ls", "<cmd>LoveStop<cr>", ft = "lua", desc = "Stop LÖVE" },
}

function M.setup()
  require("love2d").setup({})
end

return M
