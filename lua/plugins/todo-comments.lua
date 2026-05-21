-- todo-comments.nvim | Highlight, list and search todo comments in your projects
-- https://github.com/folke/todo-comments.nvim

---@return nil
local function todo_jump_prev()
  require("todo-comments").jump_prev()
end

---@return nil
local function todo_jump_next()
  require("todo-comments").jump_next()
end

---@class plugins.TodoCommentsOpts
---@field keywords table<string, any>
---@field highlight table<string, any>
---@field colors table<string, any>
---@field search table<string, any>

local M = {}

M.keys = {
  { "[t", todo_jump_prev, desc = "Previous todo comment" },
  { "]t", todo_jump_next, desc = "Next todo comment" },
  { "<leader>fT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
  { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Todo" },
  { "<leader>xT", "<cmd>TodoQuickFix keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Quickfix)" },
  { "<leader>xt", "<cmd>TodoQuickFix<cr>", desc = "Todo (Quickfix)" },
}

---@type plugins.TodoCommentsOpts
local opts = {
  keywords = {
    FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "FIX", "ISSUE" } },
    HACK = { icon = "󰈸 ", color = "warning" },
    NOTE = { icon = "󰍨 ", color = "hint", alt = { "INFO" } },
    PERF = { icon = "󰓅 ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    TEST = { icon = "󰂓 ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
    TODO = { icon = " ", color = "info", alt = { "WIP" } },
    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
  },
  highlight = {
    keyword = "fg",
    after = "",
    pattern = ".*<((KEYWORDS)%(\\(.{-1,}\\))?):",
    comments_only = true,
    exclude = { "help", "log" },
  },
  colors = {
    default = { "Include", "#7C3AED" },
    error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
    hint = { "DiagnosticHint", "#10B981" },
    info = { "DiagnosticInfo", "#2563EB" },
    test = { "Include", "#FF00FF" },
    warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
  },
  search = {
    pattern = [[\b(KEYWORDS)(\([^\)]*\))?:]],
  },
}

function M.init()
  vim.api.nvim_set_hl(0, "Todo", {})
  vim.api.nvim_create_autocmd("ColorScheme", {
    ---@param _ev vim.api.keyset.create_autocmd.callback_args
    callback = function(_ev)
      vim.api.nvim_set_hl(0, "Todo", {})
    end,
  })
end

function M.setup()
  require("todo-comments").setup(opts)
end

return M
