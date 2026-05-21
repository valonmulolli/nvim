vim.opt_local.expandtab = false -- Odin uses tabs
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.autoindent = true
vim.opt_local.cindent = true      -- Use cindent for stable brace-based indentation
vim.opt_local.smartindent = false -- Disable smartindent (known for left-jumping bugs)
vim.opt_local.indentexpr = ""     -- Disable buggy Treesitter indentation
