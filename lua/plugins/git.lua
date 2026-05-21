---@class plugins.GitsignsOpts
---@field signs table<string, any>
---@field current_line_blame boolean

local M = {}

---@type plugins.GitsignsOpts
local opts = {
  signs = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "┆" },
  },
  current_line_blame = false,
}

M.keys = {
  { "]h", "<cmd>Gitsigns next_hunk<CR>", desc = "Next hunk" },
  { "[h", "<cmd>Gitsigns prev_hunk<CR>", desc = "Previous hunk" },
  { "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", mode = { "n", "v" }, desc = "Stage hunk" },
  { "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", mode = { "n", "v" }, desc = "Reset hunk" },
  { "<leader>gS", "<cmd>Gitsigns stage_buffer<CR>", desc = "Stage buffer" },
  { "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<CR>", desc = "Undo stage hunk" },
  { "<leader>gR", "<cmd>Gitsigns reset_buffer<CR>", desc = "Reset buffer" },
  { "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", desc = "Preview hunk" },
  { "<leader>gb", "<cmd>Gitsigns blame_line<CR>", desc = "Blame line" },
  { "<leader>gd", "<cmd>Gitsigns diffthis<CR>", desc = "Diff this" },
}

function M.setup()
  require("gitsigns").setup(opts)
end

return M
