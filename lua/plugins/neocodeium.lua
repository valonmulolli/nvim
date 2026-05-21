local M = {}

---@return nil
local function neocodeium_accept_word()
  require("neocodeium").accept_word()
end

---@return nil
local function neocodeium_accept_line()
  require("neocodeium").accept_line()
end

---@return nil
local function neocodeium_clear()
  require("neocodeium").clear()
end

function M.setup()
  ---@type table<string, any>
  local neocodeium = require("neocodeium")
  neocodeium.setup({
    silent = true,
  })

  vim.keymap.set("i", "<C-e>", neocodeium_accept_word)
  vim.keymap.set("i", "<C-r>", neocodeium_accept_line)
  vim.keymap.set("i", "<C-x>", neocodeium_clear)
end

return M
