-- nvim-treesitter | Nvim Treesitter configurations and abstraction layer
-- https://github.com/nvim-treesitter/nvim-treesitter

---Set default highlights for rainbow-delimiters
---NOTE: Prevents errors when switching colorschemes which don't have these highlights set.
local M = {}

---@class plugins.TreesitterContextOpts
---@field max_lines integer

---@class plugins.TreesitterOpts
---@field disable fun(_lang: string, buf: integer): boolean|nil
---@field ensure_installed string[]
---@field ignore_install string[]
---@field auto_install boolean
---@field autotag table<string, boolean>
---@field highlight table<string, boolean>
---@field indent table<string, any>
---@field incremental_selection table<string, any>
---@field textobjects table<string, any>

---@type plugins.TreesitterOpts
local opts = {
    ---@param _lang string
    ---@param buf integer
    ---@return boolean|nil
    disable = function(_lang, buf)
      ---@type integer
      local max_filesize = 100 * 1024 -- 100 KB
      ---@type boolean, table<string, any>|nil
      local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
    ensure_installed = {
      "astro",
      "bash",
      "c",
      "comment",
      "css",
      "dockerfile",
      "editorconfig",
      "gitignore",
      "go",
      "gomod",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "just",
      "jsonc",
      "lua",
      "luadoc",
      "markdown",
      "markdown_inline",
      "python",
      "rust",
      "query",
      "regex",
      "toml",
      "typescript",
      "tsx",
      "vim",
      "vimdoc",
      "yaml",
      "zig",
      "odin",
    },
    ignore_install = {},
    auto_install = true,
    autotag = { enable = true },
    highlight = { enable = true },
    indent = {
      enable = true,
      disable = { "yaml", "odin" },
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
    },
}

function M.init()
  vim.api.nvim_set_hl(0, "TreesitterContext", { link = "Normal", default = true })
  vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { link = "CursorLineNr", default = true })
  vim.api.nvim_create_autocmd("ColorScheme", {
    ---@param _ev vim.api.keyset.create_autocmd.callback_args
    callback = function(_ev)
      vim.api.nvim_set_hl(0, "TreesitterContext", { link = "Normal", default = true })
      vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { link = "CursorLineNr", default = true })
    end,
  })
end

function M.setup()
  require("ts_context_commentstring").setup({
    enable_autocmd = false,
    languages = {
    },
  })
  pcall(vim.api.nvim_del_augroup_by_name, "context_commentstring_ft")
  require("treesitter-context").setup({ max_lines = 1 })

  ---@type boolean, table<string, any>|nil
  local ok, configs = pcall(require, "nvim-treesitter.configs")
  if ok and configs then
    configs.setup(opts)
  else
    ---@type boolean, table<string, any>|nil
    local ts_ok, ts = pcall(require, "nvim-treesitter")
    if ts_ok and ts then
      ts.setup(opts)
    end
  end
end

return M
