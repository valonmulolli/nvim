-- local cmd_wrapper = function(cmd)
--   return function()
--     local action = (cmd):gsub("Session", "")
--     local cwd = vim.fn.getcwd()
--     vim.notify(("%s session: %s"):format(action, cwd), 2, {})
--     vim.cmd(cmd)
--   end
-- end

-- local delete_session = cmd_wrapper("SessionDelete")
-- local save_session = cmd_wrapper("SessionSave")

local M = {}
local paths = require("config.paths")

M.keys = {
  { "<leader>sd", "<cmd>SessionDelete<CR>", desc = "Delete current session" },
  { "<leader>ss", "<cmd>SessionSave<CR>", desc = "Save current session" },
  { "<leader>sl", "<cmd>SessionRestore<CR>", desc = "Restore session" },
}

function M.setup()
  require("auto-session").setup({
    log_level = "error",
    auto_restore_enabled = true,
    auto_save_enabled = true,
    auto_session_suppress_dirs = { paths.dev_root },
    bypass_session_save_file_types = { "dashboard", "snacks_dashboard", "oil" },
  })
end

return M
