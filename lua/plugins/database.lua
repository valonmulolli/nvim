return {
    {
        'tpope/vim-dadbod',
        dependencies = {
            'kristijanhusak/vim-dadbod-ui',
            'kristijanhusak/vim-dadbod-completion',
        },
        keys = {
            { '<Space>du', ':DBUIToggle<cr>',        desc = 'Toggle DB UI' },
            { '<Space>db', ':DBUIFindBuffer<cr>',    desc = 'DB Find buffer' },
            { '<Space>dr', ':DBUIRenameBuffer<cr>',  desc = 'DB Rename buffer' },
            { '<Space>dl', ':DBUILastQueryInfo<cr>', desc = 'DB Last query' },
        },
        config = function()
            local function db_completion()
                require('cmp').setup.buffer({
                    sources = {
                        { name = "vim-dadbod-completion" },
                    },
                })
            end

            vim.api.nvim_create_autocmd('FileType', {
                pattern = { 'sql', 'plsql', 'mysql' },
                callback = function()
                    -- Set omnifunc for SQL-related file types
                    vim.bo.omnifunc = 'vim_dadbod_completion#omni'

                    -- Schedule db_completion for auto-completion
                    vim.schedule(db_completion)
                end,
            })
        end,

        cmd = {
            'DBUIToggle',
            'DBUI',
            'DBUIAddConnection',
            'DBUIFindBuffer',
            'DBUIRenameBuffer',
            'DBUILastQueryInfo',
        },
        init = function()
            vim.g.db_ui_save_location = '/home/v47on/Sql'
            vim.g.db_ui_show_database_icon = true
            vim.g.db_ui_tmp_query_location = '/home/v47on/Sql'
            vim.g.db_ui_use_nerd_fonts = true
            vim.g.db_ui_use_nvim_notify = true
            vim.g.db_ui_use_nerd_fonts = 1
            vim.g.db_ui_winwidth = 30
            vim.g.db_ui_show_help = 0
            vim.g.db_ui_win_position = "left"
        end,
    },
}
