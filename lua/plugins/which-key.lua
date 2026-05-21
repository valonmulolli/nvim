-- Which-key | Configurations for plugin WhichKey.nvim
-- https://github.com/folke/which-key.nvim
---@module "which-key"

---@class plugins.WhichKeyOpts
---@field preset string
---@field icons table<string, any>
---@field win table<string, any>
---@field replace table<string, any>

local M = {}

---@type plugins.WhichKeyOpts
local opts = {
  preset = "classic",
  icons = { mappings = true },
  win = {
    row = math.huge,
    border = { "─", "─", "─", " ", "─", "", "", " " },
  },
  replace = {
    key = {
      { "<BS>", "BS" },
      { "<CR>", "RET" },
      { "<Esc>", "ESC" },
      { "<Space>", "SPC" },
      { "<Tab>", "TAB" },
    },
  },
}

function M.setup()
  ---@type table<string, any>
  local wk = require("which-key")
  wk.setup(opts)
  wk.add({
    { "[", group = "Prev" },
    { "]", group = "Next" },
    { "g", group = "Goto" },
    { "<leader>a", group = "AI" },
    { "<leader>b", group = "Buffers" },
    { "<leader>c", group = "Code" },
    { "<leader>D", group = "Database" },
    { "<leader>d", group = "Debug" },
    { "<leader>f", group = "Find" },
    { "<leader>g", group = "Git" },
    { "<leader>m", group = "Multicursor" },
    { "<leader>n", group = "New" },
    { "<leader>o", group = "Options" },
    { "<leader>p", group = "Plugins" },
    { "<leader>r", group = "Run" },
    { "<leader>s", group = "Sessions" },
    { "<leader>t", group = "Terminal" },
    { "<leader>u", group = "UI Toggles" },
    { "<leader>v", group = "Windows" },
    { "<leader>x", group = "Diagnostics" },
  })
end

return M
