local opt = vim.opt

-- vim.g.mapleader = " "

opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.cursorline = true
opt.number = true
opt.relativenumber = true
opt.title = true
opt.hlsearch = true
opt.backup = false
opt.showcmd = true
opt.swapfile = false
opt.clipboard:append("unnamedplus")
opt.cmdheight = 1
opt.termguicolors = true
opt.laststatus = 2
opt.expandtab = true
opt.linebreak = true
opt.autoindent = true
opt.breakindent = true
opt.smartindent = true
-- opt.listchars = {
--   nbsp = "␣",
--   precedes = "←",
--   extends = "→",
--   tab = "¬ ",
--   conceal = "※",
-- }
-- opt.list = true
opt.showbreak = string.rep(" ", 3)
opt.scrolloff = 10
opt.backupskip = { "/tmp/*", "/private/tmp/*" }
opt.inccommand = "split"
opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
opt.smarttab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.wrap = true           -- No Wrap lines
opt.backspace = { "start", "eol", "indent" }
opt.path:append({ "**" }) -- Finding files - Search down into subfolders
opt.wildignore:append({ "*/node_modules/*" })
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.splitkeep = "cursor"
opt.iskeyword:append("-")
opt.mouse = "a"
opt.completeopt = "menuone,noselect"

vim.cmd("hi CursorLine cterm=NONE ctermbg=NONE guibg=NONE")

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Add asterisks in block comments
opt.formatoptions:append({ "r" })

vim.cmd([[au BufNewFile,BufRead *.astro setf astro]])
vim.cmd([[au BufNewFile,BufRead Podfile setf ruby]])

if vim.fn.has("nvim-0.8") == 1 then
	vim.opt.cmdheight = 0
end

vim.g.editorconfig = false

