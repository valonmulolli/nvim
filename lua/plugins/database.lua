return {
    {
        'tpope/vim-dadbod',
        dependencies = {
            'kristijanhusak/vim-dadbod-ui',
            'kristijanhusak/vim-dadbod-completion',
        },
        keys = {
            { '<leader>du', ':DBUIToggle<cr>',     desc = 'Toggle DB UI' },
            { '<leader>db', ':DBUIFindBuffer<cr>', desc = 'DB Find buffer' },
            {
                '<leader>dr',
                ':DBUIRenameBuffer<cr>',
                desc = 'DB Rename buffer',
            },
            { '<leader>dl', ':DBUILastQueryInfo<cr>', desc = 'DB Last query' },
        },
        config = function()
            local function db_completion()
                require('cmp').setup.buffer({
                    sources = {
                        { name = "vim-dadbod-completion" },
                    },
                })
            end

            vim.g.db_ui_save_location = '/home/v47on/Sql'


            vim.api.nvim_create_autocmd('FileType', {
                pattern = {
                    'sql',
                },
                command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
            })

            vim.api.nvim_create_autocmd('FileType', {
                pattern = {
                    'sql',
                    'plsql',
                    'mysql',
                },
                callback = function()
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
            vim.g.db_ui_use_nerd_fonts = 1
            vim.g.db_ui_winwidth = 30
            vim.g.db_ui_show_help = 0
            vim.g.db_ui_use_nvim_notify = 1
            vim.g.db_ui_win_position = "left"
        end,
    },
}
