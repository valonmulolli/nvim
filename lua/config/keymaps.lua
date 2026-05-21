-- General neovim keyboard mapping definitions

---@type config.UtilModule
local util = require("config.util")

---@type vim.keymap.set.Opts
local defaults = { remap = false, silent = true }
util.register_keymaps(defaults, {
  -- Visually move lines <Up/Down>
  { "v", "<A-k>",     ":m '<-2<CR>gv=gv" },
  { "v", "<A-j>",     ":m '>+1<CR>gv=gv" },
  { "v", "<A-Up>",    ":m '<-2<CR>gv=gv" },
  { "v", "<A-Down>",  ":m '>+1<CR>gv=gv" },

  -- Keep cursor centered during half-page jumps
  { "n", "<C-d>",     "<C-d>zz" },
  { "n", "<C-u>",     "<C-u>zz" },

  -- Duplicate line
  { "n", "<C-S-d>",   "Yp" }, -- Alt shifted to Control+Shift-D for consistency

  -- Join lines while keeping cursor position
  { "n", "J",         "mzJ`z" },

  -- Search and replace
  { "n", "<leader>h", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]] },

  -- delete selected text to black hole register and paste previous content
  { "x", "<leader>p", [["_dP"]] },

  -- Make Y act like other capitals
  { "n", "Y",         "y$" },

  -- Remove highlight after search with ESCAPE
  { "n", "<esc>",     "<cmd>nohlsearch<cr><esc>" },

  -- Jumplist center cursor
  { "n", "<C-o>",     "<C-o>zz" },
  { "n", "<C-i>",     "<C-i>zz" },

  -- Keep incsearch in center of buffer
  { "n", "n",         "nzzzv" },
  { "n", "N",         "Nzzzv" },

  -- Prevent jump when search under cursor
  { "n", "*",         "*N" },

  -- Search for visually highlighted text
  { "v", "*",         'y<ESC>/<c-r>"<CR>N' },

  -- Visual indentation
  { "v", "<",         "<gv" },
  { "v", ">",         ">gv" },

  -- Delete active buffer in window
  { "n", "<c-w>d",    "<cmd>bn|bd#<CR>" },

  -- Save document (Ctrl+S)
  {
    { "i",                     "n" },
    "<c-s>",
    "<cmd>silent! update<cr>",
    { desc = "Save" },
  },

  { "n", "<Leader>q",  ":q<CR>",             { desc = "Quit window" } },

  -- Create new buffers/tabs
  { "n", "<leader>nt", "<cmd>tabnew<CR>",    { desc = "New tab" } },
  { "n", "<leader>nf", "<cmd>enew<CR>",      { desc = "New file" } },
  { "n", "<leader>ps", "<cmd>PackStatus<CR>", { desc = "Pack status" } },
  { "n", "<leader>pu", "<cmd>PackUpdate<CR>", { desc = "Pack update" } },
  { "n", "<leader>pU", "<cmd>PackUpdate!<CR>", { desc = "Pack update force" } },
  -- Windows and Panes
  { "n", "<leader>vv", "<C-w>v",             { desc = "Split Vertically" } },
  { "n", "<leader>vh", "<C-w>s",             { desc = "Split Horizontally" } },
  { "n", "<leader>ve", "<C-w>=",             { desc = "Equal Split" } },
  { "n", "<leader>vx", ":close<CR>",         { desc = "Close split" } },
  { "n", "<leader>vo", ":only<CR>",          { desc = "Single Pane" } },
  { "n", "<leader>vq", "<cmd>silent! wq<CR>", { desc = "Quit window" } },

  -- Native commenting
  { "n", "<leader>/",  "gcc",                { remap = true, desc = "Toggle Comment" } },
  { "v", "<leader>/",  "gc",                 { remap = true, desc = "Toggle Comment" } },

  -- Native terminal toggle
  { "n", "<leader>tt",  util.toggle_terminal, { desc = "Toggle Terminal" } },
  { "n", "<C-/>",      util.toggle_terminal, { desc = "Toggle Terminal" } },
  { "n", "<C-_>",      util.toggle_terminal, { desc = "Toggle Terminal" } },
  { "t", "<C-/>",      util.toggle_terminal, { desc = "Toggle Terminal" } },
  { "t", "<C-_>",      util.toggle_terminal, { desc = "Toggle Terminal" } },

  { "t", "<Esc>",      "<C-\\><C-n>",        { desc = "Exit terminal mode" } },

})
