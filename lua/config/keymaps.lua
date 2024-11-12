-- General neovim keyboard mapping definitions
local util = require("config.util")

local defaults = { remap = false, silent = true }
util.register_keymaps(defaults, {
  -- Make Y act like other capitals
  { "n",          "Y",           "y$" },

  -- Prevent <Delete> from yanking
  { "v",          "<del>",       '"_d' },

  -- Banish Q to the shadow realm
  { "n",          "Q",           "<nop>" },

  -- Ctrl-Z undo in insert
  { "i",          "<c-z>",       "<c-o>:u<CR>" },

  -- Remove highlight after search with ESCAPE
  { "n",          "<esc>",       ":nohlsearch<cr><esc>" },

  -- Jumplist center cursor
  { "n",          "<C-o>",       "<C-o>zz" },
  { "n",          "<C-i>",       "<C-i>zz" },

  -- Keep incsearch in center of buffer
  { "n",          "n",           "nzzzv" },
  { "n",          "N",           "Nzzzv" },

  -- Prevent jump when search under cursor
  { "n",          "*",           "*N" },

  -- Search for visually highlighted text
  { "v",          "*",           'y<ESC>/<c-r>"<CR>N' },

  -- Visual indentation
  { "v",          "<",           "<gv" },
  { "v",          ">",           ">gv" },

  -- Navigate buffer
  { "n",          "[b",          ":bprevious<CR>",      { desc = "Previous buffer" } },
  { "n",          "]b",          ":bnext<CR>",          { desc = "Next buffer" } },

  -- Delete active buffer in window
  { "n",          "<c-w>d",      "<cmd>bn|bd#<CR>" },

  -- General save document
  { { "i", "n" }, "<c-s>",       "<cmd>write<CR>" },

  -- Create new buffers/tabs
  { "n",          "<leader>nt",  "<cmd>tabnew<CR>",     { desc = "New tab" } },
  { "n",          "<leader>nf",  "<cmd>enew<CR>",       { desc = "New file" } },

  -- Code Runner
  { "n",          '<leader>r',   ':RunFile<CR>',        { desc = 'Run file' } },
  { "n",          '<leader>rq',  ':RunClose<CR>',       { desc = 'Close runner' } },
  { "n",          '<leader>rft', ':RunFile tab<CR>',    { desc = 'Run file in new tab' } },
  { "n",          '<leader>rp',  ':RunProject<CR>',     { desc = 'Run project' } },

  -- Tabs
  { "n",          "<TAB>",       ":tabnext<Return>",    { desc = "Next tab" } },
  { "n",          "<s-TAB>",     ":tabprev<Return>",    { desc = "Previous tab" } },



  -- Quit current window
  { "n",          "<leader>wq",  ":wq<CR>",             { desc = "Quit window" } },

  { 'n',          '<Leader>q',   ':q<CR>',              { desc = 'Quit window' } },

  { "n", "<leader>y", ":<C-u>s/<[^>]*>/\r&\r/g<CR>:<C-u>g/^$/d<CR>gg=G", { desc = "Prettify HTML and format" } }

})
