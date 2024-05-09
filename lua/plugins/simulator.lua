return {
    {
        "dimaportenko/telescope-simulators.nvim",
        lazy = false,
        config = function()
            require("simulators").setup({
                android_emulator = true,
                apple_simulator = false,
            })
        end,
    },
}
