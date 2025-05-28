-- General neovim keyboard mapping definitions
local util = require("config.util")

local defaults = { remap = false, silent = true }
util.register_keymaps(defaults, {
  -- Visually move lines <Up/Down>
  { "v", "<A-k>",      ":m '<-2<CR>gv=gv" },
  { "v", "<A-j>",      ":m '>+1<CR>gv=gv" },
  { "v", "<A-Up>",     ":m '<-2<CR>gv=gv" },
  { "v", "<A-Down>",   ":m '>+1<CR>gv=gv" },

  -- Duplicate line
  { "n", "<C-d>",      "Yp" },

  -- Search and replace
  { "n", "<leader>h", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  },

  -- Make Y act like other capitals
  { "n",          "Y",          "y$" },

  -- Prevent <Delete> from yanking
  { "v",          "<del>",      '"_d' },

  -- Banish Q to the shadow realm
  -- { "n",          "Q",          "<nop>" },

  -- Ctrl-Z undo in insert
  { "i",          "<c-z>",      "<c-o>:u<CR>" },

  -- Remove highlight after search with ESCAPE
  { "n",          "<esc>",      "<cmd>nohlsearch<cr><esc>" },

  -- Jumplist center cursor
  { "n",          "<C-o>",      "<C-o>zz" },
  { "n",          "<C-i>",      "<C-i>zz" },

  -- Keep incsearch in center of buffer
  { "n",          "n",          "nzzzv" },
  { "n",          "N",          "Nzzzv" },

  -- Prevent jump when search under cursor
  { "n",          "*",          "*N" },

  -- Search for visually highlighted text
  { "v",          "*",          'y<ESC>/<c-r>"<CR>N' },

  -- Visual indentation
  { "v",          "<",          "<gv" },
  { "v",          ">",          ">gv" },

  -- Navigate buffer
  { "n",          "<S-Tab>",    "<cmd>bprevious<CR>",      { desc = "Previous buffer" } },
  { "n",          "<Tab>",      "<cmd>bnext<CR>",          { desc = "Next buffer" } },

  -- Delete active buffer in window
  { "n",          "<c-w>d",     "<cmd>bn|bd#<CR>" },

  -- General save document
  { { "i", "n" }, "<c-s>",      "<cmd>write<CR>" },

  -- Code Runner
  { "n",          "<leader>r",  ":RunFile<CR>",            { desc = "Run file" } },
  { "n",          "<leader>rq", ":RunClose<CR>",           { desc = "Close runner" } },
  { "n",          "<leader>rt", ":RunFile tab<CR>",        { desc = "Run file in new tab" } },
  { "n",          "<leader>rp", ":RunProject<CR>",         { desc = "Run project" } },

  -- Quit current window
  { "n",          "<leader>wq", ":wq<CR>",                 { desc = "Quit window" } },

  { "n",          "<Leader>q",  ":q<CR>",                  { desc = "Quit window" } },

  -- Create new buffers/tabs
  { "n",          "<leader>nt", "<cmd>tabnew<CR>",         { desc = "New tab" } },
  { "n",          "<leader>nf", "<cmd>enew<CR>",           { desc = "New file" } },
})
