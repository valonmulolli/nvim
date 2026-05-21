---@class plugins.lsp.KeymapsModule
---@field initialize_keymaps fun(client: vim.lsp.Client, bufnr: integer): nil

---@type plugins.lsp.KeymapsModule
local M = {}

---@type string[]
local rounded_border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

---@return nil
local function diagnostic_prev()
  vim.diagnostic.jump({ count = -1 })
  vim.cmd("normal! zz")
end

---@return nil
local function diagnostic_next()
  vim.diagnostic.jump({ count = 1 })
  vim.cmd("normal! zz")
end

---@return nil
local function diagnostic_prev_error()
  vim.diagnostic.jump({
    count = -1,
    severity = vim.diagnostic.severity.ERROR,
  })
  vim.cmd("normal! zz")
end

---@return nil
local function diagnostic_next_error()
  vim.diagnostic.jump({
    count = 1,
    severity = vim.diagnostic.severity.ERROR,
  })
  vim.cmd("normal! zz")
end

---@return nil
local function diagnostic_open_cursor_float()
  vim.diagnostic.open_float({
    border = vim.g.border or "rounded",
    focusable = true,
    scope = "cursor",
  })
end

---@return nil
local function signature_help_with_border()
  vim.lsp.buf.signature_help({ border = rounded_border })
end

---@return nil
local function hover_with_border()
  vim.lsp.buf.hover({ border = rounded_border })
end

-- Initialize and attach Language Server keymaps to the active buffer
---@param client vim.lsp.Client
---@param bufnr integer
---@return nil
---@type fun(client: vim.lsp.Client, bufnr: integer): nil
M.initialize_keymaps = function(client, bufnr)
  ---@type config.UtilModule
  local util = require("config.util")
  ---@type vim.keymap.set.Opts
  local opts = { buf = bufnr, remap = false, silent = true }

  -- stylua: ignore
  util.register_keymaps(opts, {
    { "n",          "<leader>cl", "<cmd>LspInfo<cr>",          desc = "Open LspInfo" },

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    { "n",          "gD",         vim.lsp.buf.declaration,     { desc = "Goto declaration" } },
    { "n",          "gd",         vim.lsp.buf.definition,      { desc = "Goto definition" } },
    { "n",          "gi",         vim.lsp.buf.implementation,  { desc = "Goto implementation" } },
    { "n",          "gr",         vim.lsp.buf.references,      { desc = "Goto references" } },
    { "n",          "gy",         vim.lsp.buf.type_definition, { desc = "Show type definitions" } },

    { "i",          "<C-y>",      signature_help_with_border,  { desc = "Signature Help" } },
    { "n",          "K",          hover_with_border,           { desc = "Show hover" } },
    { "n",          "gK",         signature_help_with_border,  { desc = "Signature Help" } },

    { "n",          "<leader>cC", function() vim.lsp.codelens.enable(true, { bufnr = bufnr }) end, { desc = "Enable Codelens" } },
    { "n",          "<leader>cr", vim.lsp.buf.rename,          { desc = "Rename" } },

    { { "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,     { desc = "Code Action" } },
    -- { { "n", "v" }, "<leader>cf", vim.lsp.buf.format,          { desc = "Format document" } },

    -- Diagnostic navigation
    { "n", "[d", diagnostic_prev, { desc = "Previous diagnostic" } },
    { "n", "]d", diagnostic_next, { desc = "Next diagnostic" } },
    { "n", "[D", diagnostic_prev_error, { desc = "Previous Error" } },
    { "n", "]D", diagnostic_next_error, { desc = "Next Error" } },
    { "n", "<leader>xd", diagnostic_open_cursor_float, { desc = "Line Diagnostics" } },
  })

  -- stylua: ignore
  util.register_keymaps(opts, {
    { "n", "<C-k>", signature_help_with_border, { desc = "Signature Help" } },
  })
end

---@return plugins.lsp.KeymapsModule
return M
