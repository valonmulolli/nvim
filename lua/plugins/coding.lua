return {

    -- lazy.nvim:
    {
        "smoka7/multicursors.nvim",
        event = "VeryLazy",
        dependencies = {
            'nvimtools/hydra.nvim',
        },
        opts = {},
        cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
        keys = {
            {
                mode = { 'v', 'n' },
                '<Leader>k',
                '<cmd>MCstart<cr>',
                desc = 'Create a selection for selected text or word under the cursor',
            },
        },
    },
    {
       "ThePrimeagen/vim-be-good",
       cmd = "VimBeGood",
       config = true
    },
    {
        "jellydn/hurl.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter"
        },
        ft = "hurl",
        opts = {
            -- Show debugging info
            debug = false,
            -- Show notification on run
            show_notification = false,
            -- Show response in popup or split
            mode = "split",
            -- Default formatter
            formatters = {
                json = { 'jq' }, -- Make sure you have install jq in your system, e.g: brew install jq
                html = {
                    'prettier', -- Make sure you have install prettier in your system, e.g: npm install -g prettier
                    '--parser',
                    'html',
                },
                xml = {
                    'tidy', -- Make sure you have installed tidy in your system, e.g: brew install tidy-html5
                    '-xml',
                    '-i',
                    '-q',
                },
            },
            -- Default mappings for the response popup or split views
            mappings = {
                close = 'q',      -- Close the response popup or split view
                next_panel = '<C-n>', -- Move to the next response popup window
                prev_panel = '<C-p>', -- Move to the previous response popup window
            },
        },
        keys = {
            -- Run API request
            { "<leader>aA",  "<cmd>HurlRunner<CR>",        desc = "Run All requests" },
            { "<leader>aa",  "<cmd>HurlRunnerAt<CR>",      desc = "Run Api request" },
            { "<leader>ae", "<cmd>HurlRunnerToEntry<CR>", desc = "Run Api request to entry" },
            { "<leader>aE", "<cmd>HurlRunnerToEnd<CR>",   desc = "Run Api request from current entry to end" },
            { "<leader>am", "<cmd>HurlToggleMode<CR>",    desc = "Hurl Toggle Mode" },
            { "<leader>av", "<cmd>HurlVerbose<CR>",       desc = "Run Api in verbose mode" },
            -- Run Hurl request in visual mode
            { "<leader>a",  ":HurlRunner<CR>",            desc = "Hurl Runner",                              mode = "v" },
        },
    },

    {
        'barrett-ruth/live-server.nvim',
        build = 'pnpm add -g live-server',
        cmd = { 'LiveServerStart', 'LiveServerStop' },
        config = true,
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
}
