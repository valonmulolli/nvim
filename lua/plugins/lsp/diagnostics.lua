-- Configure diagnostics for Neovim
---@type config.IconsModule
local icons = require("config.icons")

-- Map new names for lsp diagnostic messages
---@class plugins.lsp.diagnostics.ClientMapEntry
---@field [1] string
---@field [2] string

---@type plugins.lsp.diagnostics.ClientMapEntry[]
local client_map = {
  { "Lua Diagnostics.",  "LuaLS" },
  { "Lua Syntax Check.", "LuaLS" },
}

-- Allow for replacing diagnostic source from matching name
---@param diagnostic table
---@return string
local rename_diagnostic_source = function(diagnostic)
  for _, item in pairs(client_map) do
    if diagnostic.source == item[1] then
      return item[2]
    end
  end
  return diagnostic.source
end

---@param message string
---@param max_len integer
---@return string
local truncate_message = function(message, max_len)
  message = message:gsub("%s+", " ")
  if #message <= max_len then
    return message
  end
  return message:sub(1, max_len - 3) .. "..."
end

-- Format diagnostic virtual text message
---@param diagnostic table
---@return string
local format = function(diagnostic)
  ---@type string
  local severity_name = diagnostic.severity
    and (vim.diagnostic.severity[diagnostic.severity] or ""):lower():gsub("^%l", string.upper)
    or "Error"
  ---@type string
  local icon = icons.diagnostics[severity_name] or "●"
  ---@type string
  local name = rename_diagnostic_source(diagnostic)

  -- Deduplicate message if it starts with the source name
  ---@type string
  local message = diagnostic.message:gsub("^" .. (diagnostic.source or "") .. ":?%s*", "")

  return string.format("%s %s: %s ", icon, name, message)
end

-- Keep virtual text concise and source-free; full details remain in float.
---@param diagnostic table
---@return string
local virtual_text_format = function(diagnostic)
  return truncate_message(diagnostic.message or "", 90)
end

-- Format diagnostic floating window prefix
---@param diagnostic table
---@return string, string
local float_prefix = function(diagnostic)
  ---@type string
  local label = vim.diagnostic.severity[diagnostic.severity]:lower():gsub("^%l", string.upper)
  ---@type string
  local text = icons.diagnostics[label] or ""
  ---@type string
  local hl = "DiagnosticSign" .. label
  return string.format("%s ", text), hl
end

-- Apply neovim lsp diagnostic configs
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
      [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
      [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
      [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticLineNrError",
      [vim.diagnostic.severity.WARN] = "DiagnosticLineNrWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticLineNrInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticLineNrHint",
    },
  },
  underline = { severity = vim.diagnostic.severity.ERROR },
  update_in_insert = false,
  severity_sort = true,
  jump = {
    on_jump = function(diagnostic, bufnr)
      if not diagnostic then
        return
      end
      vim.diagnostic.open_float({
        bufnr = bufnr,
        border = vim.g.border or "rounded",
        focusable = true,
        scope = "cursor",
      })
    end,
  },
  float = {
    border = "rounded",
    focusable = false,
    format = format,
    header = { "󰠭 Diagnostics:", "Label" },
    prefix = float_prefix,
    scope = "cursor",
    source = "if_many",
  },
  virtual_text = false,
  virtual_lines = {
    current_line = true,
    severity = { min = vim.diagnostic.severity.ERROR },
    format = virtual_text_format,
  },
})

-- Custom highlights for line numbers
---@return nil
local function set_diagnostic_highlights()
  vim.api.nvim_set_hl(0, "DiagnosticLineNrError", { fg = "#FF204E", bold = true })
  vim.api.nvim_set_hl(0, "DiagnosticLineNrWarn", { fg = "#DFFF00", bold = true })
  vim.api.nvim_set_hl(0, "DiagnosticLineNrInfo", { fg = "#98e4ff", bold = true })
  vim.api.nvim_set_hl(0, "DiagnosticLineNrHint", { fg = "#afffaf", bold = true })
end

set_diagnostic_highlights()
