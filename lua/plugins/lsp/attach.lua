-- LSP on_attach function to handle client attachment
---@type plugins.lsp.KeymapsModule
local lsp_keymaps = require("plugins.lsp.keymaps")

-- Enable document highlight (highlights other occurrences of the word under cursor)
---@param client vim.lsp.Client
---@param bufnr integer
---@return nil
local enable_document_highlighting = function(client, bufnr)
  if client:supports_method("textDocument/documentHighlight", bufnr) then
    ---@type integer
    local group = vim.api.nvim_create_augroup("LspDocumentHighlight_" .. bufnr, { clear = true })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = bufnr,
      desc = "Apply LSP document reference highlighting on CursorHold",
      group = group,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "BufLeave", "CursorMoved", "CursorMovedI", "InsertEnter" }, {
      buffer = bufnr,
      desc = "Disable LSP document reference highlighting on CursorMoved",
      group = group,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

-- On attach function to set up LSP features when a language server attaches
---@param client vim.lsp.Client
---@param bufnr integer
---@return nil
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

  -- Enable document highlighting
  enable_document_highlighting(client, bufnr)

  -- Initialize keymaps for this buffer
  lsp_keymaps.initialize_keymaps(client, bufnr)
end

---@return fun(client: vim.lsp.Client, bufnr: integer): nil
return on_attach
