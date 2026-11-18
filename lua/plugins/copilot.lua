local M = {}

function M.setup()
  require("copilot").setup({
    panel = { enabled = false },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      keymap = {
        accept = false,
        accept_word = "<C-e>",
        accept_line = "<C-r>",
        dismiss = "<C-x>",
      },
    },
    nes = { enabled = false },
  })

  local group = vim.api.nvim_create_augroup("CopilotBlinkCompletion", { clear = true })
  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "BlinkCmpMenuOpen",
    callback = function()
      vim.b.copilot_suggestion_hidden = true
    end,
  })
  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "BlinkCmpMenuClose",
    callback = function()
      vim.b.copilot_suggestion_hidden = false
    end,
  })
end

return M
