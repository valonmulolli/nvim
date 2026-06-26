local M = {}

---@class plugins.BufferlineOpts
---@field options table<string, any>

---@type plugins.BufferlineOpts
local opts = {
        options = {
            mode = "buffers",
            themable = true,
            numbers = "none",
            close_command = "bdelete! %d",
            right_mouse_command = "bdelete! %d",
            left_mouse_command = "buffer %d",
            middle_mouse_command = nil,
            indicator = {
                icon = "▎",
                style = "icon",
            },
            buffer_close_icon = "󰅖",
            modified_icon = "●",
            close_icon = "",
            left_trunc_marker = "",
            right_trunc_marker = "",
            max_name_length = 18,
            max_prefix_length = 15,
            truncate_names = true,
            tab_size = 18,
            diagnostics = "nvim_lsp",
            diagnostics_update_in_insert = false,
            ---@param count integer
            ---@param level string
            ---@return string
            diagnostics_indicator = function(count, level)
                ---@type string
                local icon = level:match("error") and "" or ""
                return " " .. icon .. count
            end,
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "File Explorer",
                    highlight = "Directory",
                    separator = true,
                },
                {
                    filetype = "snacks_layout_box",
                    text = "Explorer",
                    highlight = "Directory",
                    separator = true,
                },
            },
            color_icons = true,
            show_buffer_icons = true,
            show_buffer_close_icons = true,
            show_close_icon = true,
            show_tab_indicators = true,
            show_duplicate_prefix = true,
            persist_buffer_sort = true,
            separator_style = "thin",
            enforce_regular_tabs = false,
            always_show_bufferline = true,
            hover = {
                enabled = true,
                delay = 200,
                reveal = { "close" },
            },
        },
}

M.keys = {
        { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle Pin" },
        { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned" },
        { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>",          desc = "Delete Other Buffers" },
        { "<leader>br", "<Cmd>BufferLineCloseRight<CR>",           desc = "Delete Buffers to Right" },
        { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>",            desc = "Delete Buffers to Left" },
        { "<S-h>",      "<Cmd>BufferLineCyclePrev<CR>",            desc = "Prev Buffer" },
        { "<S-l>",      "<Cmd>BufferLineCycleNext<CR>",            desc = "Next Buffer" },
        { "[b",         "<Cmd>BufferLineCyclePrev<CR>",            desc = "Prev Buffer" },
        { "]b",         "<Cmd>BufferLineCycleNext<CR>",            desc = "Next Buffer" },
        { "[B",         "<Cmd>BufferLineMovePrev<CR>",             desc = "Move Buffer Left" },
        { "]B",         "<Cmd>BufferLineMoveNext<CR>",             desc = "Move Buffer Right" },
}

function M.setup()
    require("bufferline").setup(opts)
end

return M
