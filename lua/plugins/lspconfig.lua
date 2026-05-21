local M = {}

function M.setup()
  require("mason").setup({
    PATH = "prepend",
    ui = {
      border = "rounded",
      height = 0.8,
      width = 0.8,
    },
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  })

  require("mason-lspconfig").setup({
    ensure_installed = {
      "bashls",
      "gopls",
      "rust_analyzer",
      "templ",
      "html",
      "cssls",
      "emmet_ls",
      "fortls",
      "hyprls",
      "tailwindcss",
      "astro",
      "ols",
      "pyright",
      "clangd",
      "prismals",
      "yamlls",
      "jsonls",
      "eslint",
      "marksman",
      "sqlls",
      "wgsl_analyzer",
      "tinymist",
      "texlab",
      -- "intelephense",
      "lua_ls",
    },
  })

  require("mason-tool-installer").setup({
    ensure_installed = {
      "prettierd",
      "stylua",
      "biome",
      "clang-format",
      "taplo",
      "ruff",
      "sql-formatter",
      "sqlfluff",
      "gofumpt",
      "goimports",
      "markdownlint",
      "fprettify",
    },
  })

  vim.lsp.log.set_level(vim.log.levels.OFF)
  require("plugins.lsp.diagnostics")

  ---@type fun(client: vim.lsp.Client, bufnr: integer): nil
  local on_attach = require("plugins.lsp.attach")
  ---@type table<string, any>
  local capabilities = require("blink.cmp").get_lsp_capabilities()
  ---@type plugins.lsp.servers.Module
  local servers = require("plugins.lsp.servers")
  ---@type string[]
  local rounded_border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

  vim.lsp.config("*", {
    capabilities = capabilities,
    on_attach = on_attach,
    single_file_support = true,
  })

  vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
    config = vim.tbl_extend("force", config or {}, { border = rounded_border })
    return vim.lsp.handlers.hover(err, result, ctx, config)
  end

  vim.lsp.handlers["textDocument/signatureHelp"] = function(err, result, ctx, config)
    config = vim.tbl_extend("force", config or {}, { border = rounded_border })
    return vim.lsp.handlers.signature_help(err, result, ctx, config)
  end

  for server, config in pairs(servers.configs) do
    vim.lsp.config(server, config)
  end

  ---@param binary string|nil
  ---@return string|nil
  local function resolve_executable(binary)
    if not binary then
      return nil
    end

    if binary:find("/", 1, true) and vim.fn.executable(binary) == 1 then
      ---@type table<string, any>
      local uv = vim.uv
      return (uv and uv.fs_realpath(binary)) or binary
    end

    ---@type string
    local exepath = vim.fn.exepath(binary)
    if exepath ~= nil and exepath ~= "" then
      return exepath
    end

    ---@type string
    local mason_binary = vim.fn.stdpath("data") .. "/mason/bin/" .. binary
    if vim.fn.executable(mason_binary) == 1 then
      ---@type table<string, any>
      local uv = vim.uv
      return (uv and uv.fs_realpath(mason_binary)) or mason_binary
    end

    return nil
  end

  ---@param server string
  ---@param binary string|nil
  ---@return boolean
  ---@return string|nil
  local function can_enable(server, binary)
    if not binary then
      return true, nil
    end

    ---@type string|nil
    local resolved = resolve_executable(binary)
    if not resolved then
      return false, "missing executable: " .. binary
    end

    -- ols requires a sibling `builtin` directory next to the real binary.
    if server == "ols" then
      ---@type table<string, any>
      local uv = vim.uv
      ---@type string|nil
      local real = (uv and uv.fs_realpath(resolved)) or resolved
      if not real then
        return false, "unable to resolve executable path"
      end
      ---@type string
      local builtin_dir = vim.fs.dirname(real) .. "/builtin"
      if vim.fn.isdirectory(builtin_dir) == 0 then
        return false, "missing builtin dir: " .. builtin_dir
      end
    end

    return true, nil
  end

  ---@type string[]
  local skipped = {}
  for _, server in ipairs(servers.enable) do
    ---@type boolean, string|nil
    local ok, reason = can_enable(server, servers.executables[server])
    if ok then
      ---@type boolean, any
      local enabled, err = pcall(vim.lsp.enable, server)
      if not enabled then
        skipped[#skipped + 1] = string.format("%s (%s)", server, tostring(err))
      end
    else
      skipped[#skipped + 1] = string.format("%s (%s)", server, reason)
    end
  end

  if #skipped > 0 and not vim.g._lsp_missing_servers_notified then
    vim.g._lsp_missing_servers_notified = true
    ---@return nil
    vim.schedule(function()
      vim.notify("Skipped LSP servers: " .. table.concat(skipped, ", "), vim.log.levels.WARN)
    end)
  end
end

return M
