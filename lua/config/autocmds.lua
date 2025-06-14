-- Define autocmds for modifying general neovim capabilities.

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Custom highlights after colorscheme is loaded
autocmd('ColorScheme', {
  group = augroup('CustomHighlights', { clear = true }),
  pattern = '*',
  callback = function()
    -- Customize Copilot suggestion color
    vim.api.nvim_set_hl(0, 'CopilotSuggestion', {
      fg = '#555555',  -- Medium gray
      ctermfg = 8,     -- Dark gray in terminal
      italic = true,   -- Make it italic
      -- bold = true,
      -- underline = true,
      -- blend = 30,  -- 0-100 transparency
    })
  end,
})

autocmd({ "BufEnter", "WinLeave", "FocusLost", "VimSuspend" }, {
  desc = "Leave insert or replace mode on focus loss",
  group = augroup("FocusLostStopInsert", {}),
  pattern = "*",
  command = "if empty(&buftype) | stopinsert | endif",
})

autocmd({ "FocusLost" }, {
  desc = "Write all buffers on FocusLost",
  group = augroup("FocusLostWriteAll", {}),
  command = "silent! wall",
})

autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  desc = "Check if any buffers were changed outside of Vim on focus changed",
  group = augroup("UpdateBuffers", {}),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd.checktime()
    end
  end,
})

autocmd({ "VimResized" }, {
  desc = "Resize splits when vim window is resized",
  group = augroup("ResizeSplits", {}),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd.tabnext(current_tab)
  end,
})

autocmd({ "BufReadPost" }, {
  desc = "Go to last cursor position when opening a buffer",
  group = augroup("LastBufferLocation", {}),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

autocmd({ "InsertEnter", "InsertLeave", "TermEnter", "TermLeave" }, {
  desc = "Disable search highlight when entering insert mode",
  group = augroup("ToggleSearchHighlight", {}),
  callback = function(ev)
    if ev.event == "InsertEnter" or ev.event == "TermEnter" then
      vim.b["_lastsearch"] = vim.fn.getreg("/")
      vim.fn.setreg("/", "")
    else
      vim.fn.setreg("/", vim.b["_lastsearch"])
    end
  end,
})

autocmd({ "TextYankPost" }, {
  desc = "Highlight the region on yank",
  group = augroup("HighlightOnYank", {}),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 500 })
  end,
})

autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  desc = "Intelligent Relative Numbers | Enable",
  group = augroup("SmartHybridNumbers", {}),
  command = "if &nu && mode() != 'i' | set rnu | endif",
})

autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  desc = "Intelligent Relative Numbers | Disable",
  group = "SmartHybridNumbers",
  command = "if &nu | set nornu | endif",
})

autocmd({ "FileType" }, {
  desc = "Prevent auto-insert comment leader on all filetypes",
  group = augroup("NoAutoComment", {}),
  pattern = "*",
  command = "setlocal formatoptions-=ro",
})

autocmd({ "FileType" }, {
  desc = "Open vim help pages relative to editor instead of window",
  group = augroup("HelpPageSplit", {}),
  pattern = { "help", "man" },
  command = "wincmd K | resize 20",
})

autocmd({ "BufEnter" }, {
  desc = "Enable lazyredraw for buffers with lots of lines",
  group = augroup("LazyredrawLargeFiles", {}),
  callback = function(ev)
    local limit = 1000
    local count = vim.api.nvim_buf_line_count(ev.buf)
    if count >= limit and vim.o.lazyredraw == false then
      vim.o.lazyredraw = true
    elseif count < limit and vim.o.lazyredraw == true then
      vim.o.lazyredraw = false
    end
  end,
})

autocmd({ "BufWinEnter" }, {
  desc = "Apply 'q' keymap to close local buffers that match criteria",
  group = augroup("QuickClose", {}),
  callback = function(ev)
    local exclude = { "", "diff", "prompt", "terminal", "undotree" }
    local is_eligible = vim.bo.readonly or vim.bo.modifiable == false or vim.wo.previewwindow
    if is_eligible and not vim.tbl_contains(exclude, vim.bo.buftype) then
      vim.api.nvim_set_option_value("buflisted", false, { buf = ev.buf })
      vim.api.nvim_buf_set_keymap(ev.buf, "n", "q", "<cmd>close<cr>", { silent = true })
    end
  end,
})

autocmd({ "BufNewFile" }, {
  desc = "Inject Skeleton template when creating new file",
  group = augroup("SkeletonTemplate", {}),
  pattern = "*",
  callback = function()
    local path = vim.fn.stdpath("config")
    local fname = vim.fn.expand("<afile>:e") .. ".skel"
    vim.cmd(("silent! execute '0r %s/templates/skel/%s'"):format(path, fname))
  end,
})

autocmd({ "BufWritePre" }, {
  desc = "Create intermediate directories as needed, when saving a file",
  group = augroup("auto_create_dir", { clear = true }),
  pattern = "*",
  callback = function(ev)
    if ev.match:match("^%w%w+://") then
      return
    end
    local path = vim.uv.fs_realpath(ev.match) or ev.match
    local dir = vim.fs.dirname(path)
    if vim.fn.isdirectory(dir) == 0 then
      vim.ui.input({
        prompt = ("Directory doesn't exist: %s\nDo you want to create it? [y/N]: "):format(dir),
      }, function(choice)
        if choice == "y" then
          vim.uv.fs_mkdir(dir, tonumber("0755", 8))
        end
      end)
    end
  end,
})

-- Autoformat TypeScript/JavaScript files on save
autocmd({ "BufWritePre" }, {
  desc = "Autoformat TypeScript/JavaScript files on save",
  group = augroup("typescript_formatting", { clear = true }),
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
