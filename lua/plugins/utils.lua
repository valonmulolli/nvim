---@class plugins.MiniSurroundOpts
---@field custom_surroundings table<string, any>|nil
---@field highlight_duration integer
---@field mappings table<string, string>
---@field n_lines integer
---@field respect_selection_type boolean
---@field search_method string
---@field silent boolean

local M = {}

function M.setup()
  require("nvim-autopairs").setup({
    enable_check_bracket_line = false,
  })

  require("mini.surround").setup({
    custom_surroundings = nil,
    highlight_duration = 500,
    mappings = {
      add = "sa",
      delete = "sd",
      find = "sf",
      find_left = "sF",
      highlight = "sh",
      replace = "sr",
      update_n_lines = "sn",
      suffix_last = "l",
      suffix_next = "n",
    },
    n_lines = 20,
    respect_selection_type = false,
    search_method = "cover",
    silent = false,
  })

  ---@type table<string, any>
  local mc = require("multicursor-nvim")
  mc.setup()

  ---@type fun(mode: string|string[], lhs: string, rhs: string|function, opts?: vim.keymap.set.Opts)
  local set = vim.keymap.set

  set({ "n", "x" }, "<leader>mn", function()
    mc.matchAddCursor(1)
  end)
  set({ "n", "x" }, "<leader>ms", function()
    mc.matchSkipCursor(1)
  end)
  set({ "n", "x" }, "<leader>ma", function()
    mc.matchAddCursor(-1)
  end)
  set({ "n", "x" }, "<leader>mS", function()
    mc.matchSkipCursor(-1)
  end)

  set("n", "<c-leftmouse>", mc.handleMouse)
  set("n", "<c-leftdrag>", mc.handleMouseDrag)
  set("n", "<c-leftrelease>", mc.handleMouseRelease)
  set({ "n", "x" }, "<c-q>", mc.toggleCursor)

  mc.addKeymapLayer(function(layerSet)
    layerSet({ "n", "x" }, "<left>", mc.prevCursor)
    layerSet({ "n", "x" }, "<right>", mc.nextCursor)
    layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)
    layerSet("n", "<esc>", function()
      if not mc.cursorsEnabled() then
        mc.enableCursors()
      else
        mc.clearCursors()
      end
    end)
  end)

  ---@type fun(ns_id: integer, name: string, val: vim.api.keyset.highlight)
  local hl = vim.api.nvim_set_hl
  hl(0, "MultiCursorCursor", { reverse = true })
  hl(0, "MultiCursorVisual", { link = "Visual" })
  hl(0, "MultiCursorSign", { link = "SignColumn" })
  hl(0, "MultiCursorMatchPreview", { link = "Search" })
  hl(0, "MultiCursorDisabledCursor", { reverse = true })
  hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
  hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
end

return M
