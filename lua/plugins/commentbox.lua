return {
    {
        "LudoPinelli/comment-box.nvim",
        opts = {},
        vscode = true,
        keys = {
            { "<leader>Cb", "<cmd>CBccbox<CR>",   mode = { "n", "v" }, desc = "Comment Box" },
            { "<leader>Ct", "<cmd>CBllline<CR>",  mode = { "n", "v" }, desc = "Tiled line" },
            { "<leader>Cl", "<cmd>CBline<CR>",    desc = "Line" },
            { "<leader>Cm", "<cmd>CBllbox14<CR>", mode = { "n", "v" }, desc = "Marked" },
            { "<leader>Cc", "<cmd>CBcatalog<CR>", desc = "Catalog" },
            { "<leader>Cd", "<cmd>CBd<CR>",       mode = { "n", "v" }, desc = "Delete Comment Style" },
        },
    },
}
