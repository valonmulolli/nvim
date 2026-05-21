---@return nil
local function flash_jump()
  require("flash").jump()
end

---@return nil
local function flash_treesitter()
  require("flash").treesitter()
end

---@return nil
local function flash_remote()
  require("flash").remote()
end

---@return nil
local function flash_treesitter_search()
  require("flash").treesitter_search()
end

local M = {}

M.keys = {
  { "zk", mode = { "n", "x", "o" }, flash_jump, desc = "Flash Jump" },
  { "Zk", mode = { "n", "x", "o" }, flash_treesitter, desc = "Flash Treesitter" },
  { "r", mode = "o", flash_remote, desc = "Flash Remote" },
  { "R", mode = { "o", "x" }, flash_treesitter_search, desc = "Treesitter Search" },
}

function M.setup()
  require("flash").setup({
    modes = {
      char = {
        enabled = false,
      },
    },
  })
end

return M
