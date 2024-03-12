local discipline = require("valon.discipline")

discipline.bablok()

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "x", '"_x')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

--exit from insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- New tab
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)


-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- Code Runner
keymap.set("n", "<leader>r", ":RunCode<CR>", opts)
keymap.set("n", "<leader>rf", ":RunFile<CR>", opts)
keymap.set("n", "<leader>rft", ":RunFile tab<CR>", opts)
keymap.set("n", "<leader>rp", ":RunProject<CR>", opts)
keymap.set("n", "<leader>rc", ":RunClose<CR>", opts)
keymap.set("n", "<leader>crf", ":CRFiletype<CR>", opts)
keymap.set("n", "<leader>crp", ":CRProjects<CR>", opts)

-- Simulator
vim.api.nvim_set_keymap("n", "<leader>em", ":Telescope simulators run<CR>", { noremap = true, silent = true })

--copy and paste
vim.g.neovide_input_use_logo = 1
vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })

--Llama
vim.keymap.set({ "n", "v" }, "<leader>]", ":Gen<CR>")

-- Diagnostics
keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, opts)

-- TmuxNaviagor
-- keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", { noremap = true, silent = true, description = 'window left' })
-- keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", { noremap = true, silent = true, description = 'window right' })
-- keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>", { noremap = true, silent = true, description = 'window down' })
-- keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>", { noremap = true, silent = true, description = 'window up' })

-- vim.api.nvim_set_keymap(
--   "i",
--   "<S-Tab>",
--   'pumvisible() ? "<C-p>" : "<C-h>"',
--   { expr = true, noremap = true, silent = true }
-- )
