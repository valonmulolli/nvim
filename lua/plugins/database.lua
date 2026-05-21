local M = {}
local paths = require("config.paths")

M.keys = {
  { "<leader>Du", ":DBUIToggle<cr>", desc = "Toggle DB UI" },
  { "<leader>Db", ":DBUIFindBuffer<cr>", desc = "DB Find buffer" },
  { "<leader>Dr", ":DBUIRenameBuffer<cr>", desc = "DB Rename buffer" },
  { "<leader>Dl", ":DBUILastQueryInfo<cr>", desc = "DB Last query" },
}

function M.init()
  vim.g.db_ui_save_location = paths.sql_root
  vim.g.db_ui_show_database_icon = true
  vim.g.db_ui_tmp_query_location = paths.sql_root
  vim.g.db_ui_use_nerd_fonts = false
  vim.g.db_ui_use_nvim_notify = true
  vim.g.db_ui_winwidth = 30
  vim.g.db_ui_show_help = 0
  vim.g.db_ui_win_position = "left"
end

return M
