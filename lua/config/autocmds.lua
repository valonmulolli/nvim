-- Define autocmds for modifying general Neovim behavior.
-- For global filetype settings, prefer ~/.config/nvim/after/ftdetect/.

---@type fun(event: string|string[], opts: vim.api.keyset.create_autocmd): integer
local autocmd = vim.api.nvim_create_autocmd
---@type fun(name: string, opts: vim.api.keyset.create_augroup): integer
local augroup = vim.api.nvim_create_augroup

---@param name string
---@return integer
local function group(name)
  return augroup(name, {})
end

---@type string
local last_search_key = "_lastsearch"
---@type integer
local large_file_line_limit = 1000
---@type string[]
local quick_close_exclude = { "", "diff", "prompt", "terminal" }
---@type string[]
local quick_close_exclude_filetypes = { "nvim-undotree" }

---@param _ev vim.api.keyset.create_autocmd.callback_args
---@return nil
local function checktime_if_changed(_ev)
  if vim.bo.buftype ~= "nofile" then
    vim.cmd.checktime()
  end
end

---@param ev vim.api.keyset.create_autocmd.callback_args
---@return nil
local function toggle_search_register(ev)
  if ev.event == "InsertEnter" or ev.event == "TermEnter" then
    vim.b[last_search_key] = vim.fn.getreg("/")
    vim.fn.setreg("/", "")
    return
  end
  vim.fn.setreg("/", vim.b[last_search_key])
end

---@param _ev vim.api.keyset.create_autocmd.callback_args
---@return nil
local function highlight_on_yank(_ev)
  vim.hl.on_yank({ higroup = "IncSearch", timeout = 500 })
end

---@param _ev vim.api.keyset.create_autocmd.callback_args
---@return nil
local function disable_auto_comment(_ev)
  vim.opt_local.formatoptions:remove({ "r", "o" })
end

---@param ev vim.api.keyset.create_autocmd.callback_args
---@return nil
local function toggle_lazyredraw_for_large_buffers(ev)
  ---@type integer
  local line_count = vim.api.nvim_buf_line_count(ev.buf)
  if line_count >= large_file_line_limit and vim.o.lazyredraw == false then
    vim.o.lazyredraw = true
  elseif line_count < large_file_line_limit and vim.o.lazyredraw == true then
    vim.o.lazyredraw = false
  end
end

---@param ev vim.api.keyset.create_autocmd.callback_args
---@return nil
local function setup_quick_close(ev)
  ---@type boolean
  local is_eligible = vim.bo.readonly or vim.bo.modifiable == false or vim.wo.previewwindow
  local is_excluded = vim.tbl_contains(quick_close_exclude, vim.bo.buftype)
    or vim.tbl_contains(quick_close_exclude_filetypes, vim.bo.filetype)

  if is_eligible and not is_excluded then
    vim.api.nvim_set_option_value("buflisted", false, { buf = ev.buf })
    vim.api.nvim_buf_set_keymap(ev.buf, "n", "q", "<cmd>close<cr>", { silent = true })
  end
end

autocmd({ "BufEnter", "WinLeave", "FocusLost", "VimSuspend" }, {
  desc = "Leave insert or replace mode on focus loss",
  group = group("FocusLostStopInsert"),
  pattern = "*",
  command = "if empty(&buftype) | stopinsert | endif",
})

autocmd("FocusLost", {
  desc = "Write all buffers on FocusLost if they are normal files",
  group = group("FocusLostWriteAll"),
  command = "if &modifiable && &buftype == '' | silent! wall | endif",
})

autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  desc = "Check if any buffers changed outside Neovim",
  group = group("UpdateBuffers"),
  callback = checktime_if_changed,
})

autocmd("VimResized", {
  desc = "Resize splits when Neovim window is resized",
  group = group("ResizeSplits"),
  command = "wincmd =",
})

autocmd({ "InsertEnter", "InsertLeave", "TermEnter", "TermLeave" }, {
  desc = "Store and restore search register while typing",
  group = group("ToggleSearchHighlight"),
  callback = toggle_search_register,
})

autocmd("TextYankPost", {
  desc = "Highlight the region on yank",
  group = group("HighlightOnYank"),
  callback = highlight_on_yank,
})

autocmd({ "BufEnter", "FileType" }, {
  desc = "Prevent auto-insert comment leader on all filetypes",
  group = group("NoAutoComment"),
  pattern = "*",
  callback = disable_auto_comment,
})

autocmd("FileType", {
  desc = "Open help and man pages in a dedicated top split",
  group = group("HelpPageSplit"),
  pattern = { "help", "man" },
  command = "wincmd K | resize 20",
})

autocmd("BufEnter", {
  desc = "Enable lazyredraw for buffers with lots of lines",
  group = group("LazyredrawLargeFiles"),
  callback = toggle_lazyredraw_for_large_buffers,
})

autocmd("BufWinEnter", {
  desc = "Apply q keymap to close local buffers that match criteria",
  group = group("QuickClose"),
  callback = setup_quick_close,
})
