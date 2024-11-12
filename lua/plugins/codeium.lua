return
{
    "Exafunction/codeium.vim",
    cmd = "Codeium",
    opts = {
        opts = function(_, opts)
            table.insert(opts.sources, 5, {
                name = "codeium",
                group_index = 5,
                priority = 104,
            })
        end,
    },
    event = "BufEnter",
    config = function()
        vim.keymap.set("i", '<C-e>', function()
            return vim.fn["codeium#Accept"]()
        end, { expr = true, silent = true })
        vim.api.nvim_set_keymap("i", "<C-r>", "<Cmd>call codeium#CycleCompletions(5)<CR>",
            { silent = true })
        vim.api.nvim_set_keymap("i", "<C-f>", "<Cmd>call codeium#CycleCompletions(3)<CR>",
            { silent = true })
        vim.api.nvim_set_keymap("i", "<C-x>", "<Cmd>call codeium#Clear()<CR>", { silent = true })
    end,
}
