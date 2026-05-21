---@return nil
local function conform_format()
  require("conform").format({ async = true, lsp_fallback = false })
end

---@class plugins.ConformOpts
---@field formatters_by_ft table<string, any>
---@field format_on_save fun(bufnr: integer): table<string, boolean|integer>|nil
---@field notify_on_error boolean

local M = {}

M.keys = {
  {
    "<leader>cf",
    conform_format,
    mode = { "n", "v" },
    desc = "Format buffer",
  },
}

---@type plugins.ConformOpts
local opts = {
  formatters_by_ft = {
    c = { "clang_format" },
    cpp = { "clang_format" },
    rust = { "rustfmt" },
    zig = { "zigfmt" },
    go = { "goimports", "gofmt" },
    odin = { "odinfmt" },
    lua = { "stylua" },
    python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
    fortran = { "fprettify" },
    sql = { "sqlfluff" },
    javascript = { "biome", "prettierd", "prettier", stop_after_first = true },
    javascriptreact = { "biome", "prettierd", "prettier", stop_after_first = true },
    typescript = { "biome", "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "biome", "prettierd", "prettier", stop_after_first = true },
    astro = { "prettierd", "prettier", stop_after_first = true },
    svelte = { "prettierd", "prettier", stop_after_first = true },
    vue = { "prettierd", "prettier", stop_after_first = true },
    json = { "prettierd", "prettier", stop_after_first = true },
    jsonc = { "prettierd", "prettier", stop_after_first = true },
    typst = { "typstyle" },
    markdown = { "prettierd", "prettier", stop_after_first = true },
    html = { "prettierd", "prettier", stop_after_first = true },
    htm = { "prettierd", "prettier", stop_after_first = true },
    css = { "prettierd", "prettier", stop_after_first = true },
    yaml = { "prettierd", "prettier", stop_after_first = true },
    toml = { "taplo" },
  },
  ---@param bufnr integer
  ---@return table<string, boolean|integer>|nil
  format_on_save = function(bufnr)
    ---@type table<string, boolean>
    local disable_filetypes = { sql = true }
    if disable_filetypes[vim.bo[bufnr].filetype] then
      return nil
    end
    return {
      timeout_ms = 500,
      lsp_fallback = false,
    }
  end,
  notify_on_error = true,
}

function M.setup()
  require("conform").setup(opts)
end

return M
