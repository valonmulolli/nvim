return {
  "github/copilot.vim",
  event = "InsertEnter",
  config = function()
    -- Basic Copilot settings
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_tab_fallback = ""

    -- Simple filetype settings
    vim.g.copilot_filetypes = {
      ["*"] = true,
      markdown = true,
      help = true,
      yaml = true,
      json = true,
      python = true,
      lua = true,
      rust = true,
      javascript = true,
      typescript = true,
      go = true,
    }

    -- Set up keymaps with replace_keycodes = false to prevent weird characters
    vim.keymap.set('i', '<C-e>', [[copilot#Accept('\<CR>')]], {
      expr = true,
      silent = true,
      noremap = true,
      replace_keycodes = false,
    })

    vim.keymap.set('i', '<C-c>', '<Plug>(copilot-dismiss)', {
      silent = true,
      noremap = true,
    })
    vim.keymap.set('i', '<M-]>', '<Plug>(copilot-next)', {
      silent = true,
      noremap = true,
    })
    vim.keymap.set('i', '<M-[>', '<Plug>(copilot-previous)', {
      silent = true,
      noremap = true,
    })
  end,
}
