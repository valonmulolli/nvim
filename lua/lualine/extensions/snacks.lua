-- MIT license, see LICENSE for more details.
-- Extension for snacks.nvim

local M = {}

-- Inherit base config while only overriding the filepath
-- in order to display snacks info
local default_sections = require("lualine").get_config().sections
M.sections = vim.tbl_extend("force", default_sections, {
    lualine_c = {
        {
            function()
                local cwd = vim.fn.getcwd()
                return cwd:gsub(vim.env.HOME, "~")
            end,
            icon = { "󰋊" },
        },
    },
})

M.filetypes = { "snacks", "explorer" }

return M
