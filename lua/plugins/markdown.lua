local M = {}

function M.init()
  vim.g.mkdp_filetypes = { "markdown" }
end

function M.setup()
  vim.keymap.set("n", "<leader>mdn", ":MarkdownPreview<CR>")
  vim.keymap.set("n", "<leader>mds", ":MarkdownPreviewStop<CR>")

  ---@type string
  local assets = vim.fn.stdpath("config") .. "/assets"
  ---@type string
  local markdown_css = assets .. "/md.css"
  ---@type string
  local highlight_css = assets .. "/mdhl.css"

  if vim.fn.filereadable(markdown_css) == 1 then
    vim.g.mkdp_markdown_css = markdown_css
  end

  if vim.fn.filereadable(highlight_css) == 1 then
    vim.g.mkdp_highlight_css = highlight_css
  end
end

return M
