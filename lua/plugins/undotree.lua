local M = {}

---@return nil
local function toggle_undotree()
  vim.cmd.packadd("undotree")
  vim.cmd.Undotree()
end

M.keys = {
  { "<leader>uu", toggle_undotree, desc = "Toggle Undotree" },
}

function M.init()
  vim.api.nvim_create_autocmd({ "FileType" }, {
    desc = "Set buffer options for undotree filetype",
    group = vim.api.nvim_create_augroup("UndotreeOptions", {}),
    pattern = { "nvim-undotree" },
    ---@param _ev vim.api.keyset.create_autocmd.callback_args
    callback = function(_ev)
      vim.opt_local.list = false
      vim.opt_local.spell = false
      vim.opt_local.number = false
      vim.opt_local.cursorline = true
      vim.opt_local.cursorlineopt = "both"
      vim.opt_local.signcolumn = "no"
    end,
  })
end

return M
