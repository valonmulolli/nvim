-- UI
vim.g.border = "rounded"
vim.g.c_syntax_for_h = 1
vim.opt.winborder = "rounded"

vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes:1"
vim.opt.scrolloff = 3
vim.opt.showtabline = 2
vim.opt.ruler = false
vim.opt.winminwidth = 5
vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.cursorlineopt = "number"
vim.opt.confirm = true
vim.opt.inccommand = "split"
vim.opt.virtualedit = "block"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.cmdheight = 1

-- Editing
vim.opt.textwidth = 0
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = false

-- Files, search, and windows
vim.opt.autoread = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.linebreak = true
vim.opt.mouse = "a"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = "screen"
vim.opt.timeoutlen = 250
vim.opt.ttimeoutlen = 0
vim.opt.updatetime = 250

-- Completion and clipboard
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.pumborder = "rounded"
vim.opt.pumheight = 12
vim.opt.pummaxwidth = 60
vim.opt.pumwidth = 16
vim.opt.clipboard = { "unnamed", "unnamedplus" }

-- Spell
vim.opt.spell = false
vim.opt.spelllang = { "en" }
vim.opt.spelloptions = { "camel", "noplainbuffer" }

-- Folding
vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = "v:lua.require('config.util').foldtext()"

-- Command-line completion
vim.opt.wildmenu = true
vim.opt.wildignorecase = false
vim.opt.wildmode = "list:full"
vim.opt.wildoptions = ""

-- UX tweaks
vim.opt.shortmess:append({
  C = true,
  I = true,
  c = true,
  f = true,
  W = true,
  F = true,
  s = true,
  S = true,
})
vim.opt.whichwrap:append("<,>,[]")
vim.o.guifont = "TX-02:h14"
vim.opt.guicursor:append("n-v-c:blinkon500-blinkoff500")
