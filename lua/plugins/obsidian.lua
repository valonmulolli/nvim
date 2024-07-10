return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = "Notes",
        path = "~/Documents/Dev/Notes",
      },
    },
    keys = {
      { "<leader>on", "<cmd>ObsidianNew<cr>",         desc = "New Obsidian note",               mode = "n" },
      { "<leader>oo", "<cmd>ObsidianSearch<cr>",      desc = "Search Obsidian notes",           mode = "n" },
      { "<leader>os", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick Switch",                    mode = "n" },
      { "<leader>ob", "<cmd>ObsidianBacklinks<cr>",   desc = "Show location list of backlinks", mode = "n" },
      { "<leader>ot", "<cmd>ObsidianTemplate<cr>",    desc = "Follow link under cursor",        mode = "n" },
    },


    -- templates = {
    --   subdir = "templates",
    --   date_format = "%Y-%m-%d-%a",
    --   time_format = "%H:%M",
    --   tags = "",
    -- },
  }

  -- see below for full list of options 👇
}
