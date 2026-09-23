-- nvim-treesitter | Nvim Treesitter configurations and abstraction layer
-- https://github.com/nvim-treesitter/nvim-treesitter

---Set default highlights for rainbow-delimiters
---NOTE: Prevents errors when switching colorschemes which don't have these highlights set.
local M = {}

---@class plugins.TreesitterContextOpts
---@field max_lines integer

local languages = {
  "astro",
  "bash",
  "c",
  "comment",
  "cpp",
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
  "lua",
  "luadoc",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "regex",
  "rust",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
  "zig",
  "odin",
}

local configured_languages = {}
for _, language in ipairs(languages) do
  configured_languages[language] = true
end

local indentation_disabled = {
  astro = true,
  odin = true,
  yaml = true,
}

local max_filesize = 100 * 1024

---@param buf integer
---@return boolean
local function is_large_file(buf)
  local filename = vim.api.nvim_buf_get_name(buf)
  if filename == "" then
    return false
  end

  local ok, stats = pcall(vim.uv.fs_stat, filename)
  return ok and stats ~= nil and stats.size > max_filesize
end

---@param buf integer
---@return boolean
local function start_treesitter(buf)
  local filetype = vim.bo[buf].filetype
  local language = vim.treesitter.language.get_lang(filetype)
  if not language or not configured_languages[language] or is_large_file(buf) then
    return false
  end

  local parser_available = vim.treesitter.language.add(language)
  if not parser_available then
    return false
  end

  vim.treesitter.start(buf, language)

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == buf then
      vim.wo[win].foldmethod = "expr"
      vim.wo[win].foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end
  end

  if not indentation_disabled[filetype] then
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end

  return true
end

---@param query string
---@return function
local function select_textobject(query)
  return function()
    require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
  end
end

---@param method string
---@param query string
---@return function
local function move_textobject(method, query)
  return function()
    require("nvim-treesitter-textobjects.move")[method](query, "textobjects")
  end
end

local function apply_capture_fallbacks()
  local fallbacks = {
    ["@keyword.modifier"] = "@keyword",
    ["@keyword.directive"] = "@keyword",
    ["@keyword.import"] = "@keyword",
    ["@number.float"] = "@number",
  }

  for capture, fallback in pairs(fallbacks) do
    if vim.tbl_isempty(vim.api.nvim_get_hl(0, { name = capture, link = true })) then
      vim.api.nvim_set_hl(0, capture, { link = fallback })
    end
  end
end

local function apply_rainbow_highlights()
  local links = {
    RainbowDelimiterRed = "DiagnosticError",
    RainbowDelimiterOrange = "Function",
    RainbowDelimiterYellow = "Number",
    RainbowDelimiterGreen = "String",
    RainbowDelimiterCyan = "Type",
    RainbowDelimiterBlue = "Special",
    RainbowDelimiterViolet = "Statement",
  }

  for group, link in pairs(links) do
    vim.api.nvim_set_hl(0, group, { link = link })
  end
end

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
  require("nvim-ts-autotag").setup({
    per_filetype = {
      rust = {
        enable_close = false,
        enable_rename = false,
        enable_close_on_slash = false,
      },
    },
  })
  apply_capture_fallbacks()
  apply_rainbow_highlights()
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("TreesitterCaptureFallbacks", { clear = true }),
    callback = function()
      apply_capture_fallbacks()
      apply_rainbow_highlights()
    end,
  })

  -- nvim-ts-autotag assumes a parser always exists; keep typing safe during installs.
  local autotag_internal = require("nvim-ts-autotag.internal")
  if not autotag_internal._parser_guarded then
    local function guard_parser(callback)
      return function(...)
        local ok, parser = pcall(vim.treesitter.get_parser, 0)
        if not ok or not parser then
          return
        end
        return callback(...)
      end
    end

    for _, name in ipairs({ "close_tag", "close_slash_tag", "rename_tag" }) do
      if type(autotag_internal[name]) == "function" then
        autotag_internal[name] = guard_parser(autotag_internal[name])
      end
    end

    autotag_internal._parser_guarded = true
  end

  require("ts_context_commentstring").setup({
    enable_autocmd = false,
    languages = {},
  })
  pcall(vim.api.nvim_del_augroup_by_name, "context_commentstring_ft")
  require("treesitter-context").setup({ max_lines = 1 })

  local ts = require("nvim-treesitter")
  ts.setup({})

  local textobjects = require("nvim-treesitter-textobjects")
  textobjects.setup({
    select = {
      lookahead = true,
    },
    move = {
      set_jumps = true,
    },
  })

  vim.keymap.set({ "x", "o" }, "af", select_textobject("@function.outer"), { desc = "Select function" })
  vim.keymap.set({ "x", "o" }, "if", select_textobject("@function.inner"), { desc = "Select inner function" })
  vim.keymap.set({ "x", "o" }, "ac", select_textobject("@class.outer"), { desc = "Select class" })
  vim.keymap.set({ "x", "o" }, "ic", select_textobject("@class.inner"), { desc = "Select inner class" })

  local move_modes = { "n", "x", "o" }
  vim.keymap.set(move_modes, "]m", move_textobject("goto_next_start", "@function.outer"), { desc = "Next function" })
  vim.keymap.set(move_modes, "]]", move_textobject("goto_next_start", "@class.outer"), { desc = "Next class" })
  vim.keymap.set(move_modes, "]M", move_textobject("goto_next_end", "@function.outer"), { desc = "End of next function" })
  vim.keymap.set(move_modes, "][", move_textobject("goto_next_end", "@class.outer"), { desc = "End of next class" })
  vim.keymap.set(move_modes, "[m", move_textobject("goto_previous_start", "@function.outer"), { desc = "Previous function" })
  vim.keymap.set(move_modes, "[[", move_textobject("goto_previous_start", "@class.outer"), { desc = "Previous class" })
  vim.keymap.set(move_modes, "[M", move_textobject("goto_previous_end", "@function.outer"), { desc = "End of previous function" })
  vim.keymap.set(move_modes, "[]", move_textobject("goto_previous_end", "@class.outer"), { desc = "End of previous class" })

  -- Neovim's current incremental-selection API uses documented select targets.
  vim.keymap.set("n", "gnn", function()
    vim.treesitter.select("parent")
  end, { desc = "Start Tree-sitter selection" })
  vim.keymap.set("x", "grn", function()
    vim.treesitter.select("parent")
  end, { desc = "Expand Tree-sitter selection" })
  vim.keymap.set("x", "grm", function()
    vim.treesitter.select("child")
  end, { desc = "Shrink Tree-sitter selection" })

  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("TreesitterHighlight", { clear = true }),
    callback = function(args)
      start_treesitter(args.buf)
    end,
  })

  vim.schedule(function()
    local installed = {}
    for _, language in ipairs(ts.get_installed("parsers")) do
      installed[language] = true
    end

    local missing = vim.tbl_filter(function(language)
      return not installed[language]
    end, languages)

    if #missing > 0 then
      local ok, err = pcall(ts.install, missing, { summary = true })
      if not ok then
        vim.notify("Tree-sitter parser installation failed: " .. tostring(err), vim.log.levels.ERROR)
      end
    end
  end)
end

return M
