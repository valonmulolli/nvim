local M = {}

function M.setup()
  require("copilot").setup({
    panel = { enabled = false },
    suggestion = { enabled = false },
    nes = { enabled = false },
  })
end

return M
