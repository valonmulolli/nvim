local paths = require("config.paths")

---@return nil
local function snacks_picker_files()
  Snacks.picker.files()
end

---@return nil
local function snacks_picker_grep()
  Snacks.picker.grep()
end

---@return nil
local function snacks_picker_recent()
  Snacks.picker.recent()
end

---@return nil
local function snacks_picker_buffers()
  Snacks.picker.buffers()
end

---@return nil
local function snacks_picker_config()
  Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
end

---@return nil
local function snacks_picker_diagnostics()
  Snacks.picker.diagnostics()
end

---@return nil
local function snacks_picker_diagnostics_buffer()
  Snacks.picker.diagnostics_buffer()
end

---@return nil
local function snacks_picker_projects()
  Snacks.picker.projects({
    dev = { paths.dev_root }, -- Your main dev folder
    -- Remove common files like README.md to avoid noise
    patterns = { ".git", "package.json", "Makefile", "Cargo.toml", "go.mod" },
    -- Increase depth if you keep projects in nested folders under your dev root.
    max_depth = 3,
    -- Options to make it feel more "modern"
    recent = true, -- Include projects from recently opened files
  })
end

---@return nil
local function snacks_open_explorer()
  Snacks.explorer()
end

---@return nil
local function snacks_show_notifications()
  Snacks.notifier.show_history()
end

---@return nil
local function register_snacks_toggles()
  Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
  Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
  Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
  Snacks.toggle.diagnostics():map("<leader>ud")
  Snacks.toggle.line_number():map("<leader>ul")
  Snacks.toggle
    .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
    :map("<leader>uc")
  Snacks.toggle.treesitter():map("<leader>uT")
  Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
  Snacks.toggle.inlay_hints():map("<leader>uh")
  Snacks.toggle.indent():map("<leader>ug")
  Snacks.toggle.dim():map("<leader>uD")
end

---@class plugins.SnacksOpts
---@field dashboard table<string, any>
---@field terminal table<string, any>
---@field notifier table<string, any>
---@field picker table<string, any>
---@field bigfile table<string, any>
---@field lazygit table<string, any>
---@field dim table<string, any>
---@field zen table<string, any>
---@field input table<string, any>
---@field quickfile table<string, any>
---@field scroll table<string, any>
---@field statuscolumn table<string, any>
---@field words table<string, any>
---@field layout table<string, any>
---@field debug table<string, any>
---@field indent table<string, any>
---@field toggle table<string, any>
---@field image table<string, any>

local M = {}

---@type plugins.SnacksOpts
local opts = {
    explorer = {
      trash = true,
    },

    scratch = { enabled = false },

    -- ====================
    -- Dashboard setup
    -- ====================
    dashboard = {
      enabled = true,
      row = 2,
      preset = {
        header = [[
 .--------------------------------------------.
 |██╗   ██╗██╗  ██╗███████╗ ██████╗ ███╗   ██╗|
 |██║   ██║██║  ██║╚════██║██╔═████╗████╗  ██║|
 |██║   ██║███████║    ██╔╝██║██╔██║██╔██╗ ██║|
 |╚██╗ ██╔╝╚════██║   ██╔╝ ████╔╝██║██║╚██╗██║|
 | ╚████╔╝      ██║   ██║  ╚██████╔╝██║ ╚████║|
 |  ╚═══╝       ╚═╝   ╚═╝   ╚═════╝ ╚═╝  ╚═══╝|
 '--------------------------------------------'
        ]],
        keys = {
          { key = "f", desc = "Find Files", action = snacks_picker_files },
          { key = "g", desc = "Find Text", action = snacks_picker_grep },
          { key = "r", desc = "Recent Files", action = snacks_picker_recent },
          { key = "b", desc = "Buffers", action = snacks_picker_buffers },
          { key = "e", desc = "File Explorer", action = snacks_open_explorer },
          { key = "p", desc = "Projects", action = snacks_picker_projects },
          { key = "s", desc = "Restore Session", action = ":SessionRestore" },
          { key = "c", desc = "Config", action = snacks_picker_config },
          { key = "l", desc = "LSP Health", action = ":checkhealth vim.lsp" },
          { key = "n", desc = "Notifications", action = snacks_show_notifications },
        },
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
      },
      formats = {
        footer = { "%s", align = "center" },
        header = { "%s", align = "center" },
      },
    },

    -- ====================
    -- Terminal setup
    -- ====================
    terminal = {
      enabled = false,
      win = {
        position = "bottom",
        height = 15,
        border = "rounded",
      },
    },

    -- ====================
    -- Notifications setup
    -- ====================
    notifier = {
      enabled = true,
      top_down = false,
    },

    -- ====================
    -- Picker setup
    -- ====================
    picker = {
      enabled = true,
      prompt = "> ",
      ui_select = true,
      formatters = {
        file = {
          filename_first = true,
          truncate = 100,
        },
      },
      sources = {
        files = {
          hidden = true,
        },
        explorer = {
          hidden = true,
        },
        grep = {
          hidden = true,
        },
      },
      layouts = {
        default = {
          layout = {
            box = "horizontal",
            width = 0.90,
            height = 0.90,
            {
              box = "vertical",
              border = "rounded",
              title = "{source} {live}",
              title_pos = "center",
              {
                win = "input",
                height = 1,
                border = "bottom",
              },
              { win = "list", border = "none" },
            },
            {
              win = "preview",
              title = "{preview}",
              -- border = "rounded",
              width = 0.5,
            },
          },
        },
      },
    },

    -- ====================
    -- Other modules
    -- ====================
    -- Disable bigfile mode so large .ipynb notebooks keep full editor features.
    bigfile = { enabled = false },
    lazygit = { enabled = false },
    dim = { enabled = false },
    zen = { enabled = false },
    input = { enabled = true },
    quickfile = { enabled = false },
    scroll = { enabled = true },
    statuscolumn = { enabled = false },
    words = { enabled = false },
    layout = { enabled = true },
    debug = { enabled = false },
    indent = { enabled = false },
    toggle = { enabled = true },
    image = {
      enabled = true,
    },
}

M.keys = {
    {
      "<leader>ff",
      snacks_picker_files,
      desc = "Find Files",
    },
    {
      "<leader>fg",
      snacks_picker_grep,
      desc = "Global Grep",
    },
    {
      "<leader>f/",
      snacks_picker_grep,
      desc = "Global Grep",
    },
    {
      "<leader>fr",
      snacks_picker_recent,
      desc = "Recent Files",
    },
    {
      "<leader>fb",
      snacks_picker_buffers,
      desc = "Find Buffers",
    },
    {
      "<leader>xx",
      snacks_picker_diagnostics,
      desc = "Diagnostics",
    },
    {
      "<leader>xX",
      snacks_picker_diagnostics_buffer,
      desc = "Buffer Diagnostics",
    },

    {
      "<leader>fp",
      snacks_picker_projects,
      desc = "Projects",
    },
    {
      "<leader>e",
      snacks_open_explorer,
      desc = "File Explorer",
    },
    {
      "<leader>cn",
      snacks_show_notifications,
      desc = "Notifications",
    },
}

function M.init()
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    ---@param _ev vim.api.keyset.create_autocmd.callback_args
    callback = function(_ev)
      register_snacks_toggles()
    end,
  })
end

function M.setup()
  require("snacks").setup(opts)
end

return M
