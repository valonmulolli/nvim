local M = {}

function M.init()
  vim.g.mkdp_filetypes = { "markdown" }
end

function M.setup()
  vim.keymap.set("n", "<leader>mdn", ":MarkdownPreview<CR>")
  vim.keymap.set("n", "<leader>mds", ":MarkdownPreviewStop<CR>")
end

return M
