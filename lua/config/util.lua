-- Neovim utility functions to be used across config files.

---@class config.UtilModule
---@field register_keymaps fun(options: table|nil, keymaps: config.KeymapSpec[]): nil
---@field foldtext fun(): string
---@field setup_tmux_mode fun(): nil
---@field toggle_terminal fun(): nil

---@type config.UtilModule
local M = {}

---@class config.KeymapSpec
---@field [1] string|string[] mode
---@field [2] string lhs
---@field [3] string|function rhs
---@field opts? vim.keymap.set.Opts

---Wrapper to extend options for various keymap definitions
---@param options table|nil default options for keymaps, assign `nil` to use defaults.
---@param keymaps config.KeymapSpec[] list of keymap definitions to be applied
function M.register_keymaps(options, keymaps)
  for _, map in pairs(keymaps) do
    ---@type string|string[], string, string|function, vim.keymap.set.Opts|nil
    local mode, lhs, rhs, opts = unpack(map)
    opts = vim.tbl_extend("force", options or {}, opts or {})
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

---Custom foldtext function for clean fold display
---@return string
function M.foldtext()
  ---@type string
  local line = vim.fn.getline(vim.v.foldstart)
  ---@type integer
  local line_count = vim.v.foldend - vim.v.foldstart + 1
  return line .. " ... " .. line_count .. " lines"
end

---Setup tmux status bar integration to display current vim mode
---@return nil
function M.setup_tmux_mode()
  if not vim.env.TMUX then
    return
  end

  ---@type string|nil
  local last_mode_name = nil
  ---@type string|nil
  local last_mode_color = nil
  ---@type userdata|nil
  local mode_update_timer = nil
  ---@type table<string, any>
  local uv = vim.uv

  ---@param name string
  ---@param value string
  ---@return nil
  local function set_tmux_option(name, value)
    vim.system({ "tmux", "set-option", "-g", name, value }, { detach = true })
  end

  ---@param mode_name string
  ---@return string
  local function normalize_mode_name(mode_name)
    return string.format("%-8s", mode_name)
  end

  ---@return nil
  local function update_tmux_mode()
    ---@type string
    local mode = vim.api.nvim_get_mode().mode
    ---@type table<string, string>
    local mode_map = {
      n = "NORMAL",
      i = "INSERT",
      v = "VISUAL",
      V = "V-LINE",
      ["\22"] = "V-BLOCK",
      c = "COMMAND",
      R = "REPLACE",
      t = "TERMINAL",
    }

    ---@type string
    local mode_name = normalize_mode_name(mode_map[mode] or mode:upper())
    ---@type string
    local mode_color = "#aadadb" -- Default: Cyan (Keyword)

    if mode == "v" then
      mode_color = "#DFFF00" -- VISUAL: Yellow (Warning)
    elseif mode == "V" then
      mode_color = "#31ffb6" -- V-LINE: Mint (Punctuation)
    elseif mode == "\22" then
      mode_color = "#1398b9" -- V-BLOCK: Blue (Function)
    elseif mode == "i" then
      mode_color = "#afffaf" -- INSERT: Green (String)
    elseif mode == "R" then
      mode_color = "#FF204E" -- REPLACE: Red (Error)
    elseif mode == "c" then
      mode_color = "#fff5db" -- COMMAND: Cream (Constant)
    elseif mode == "t" then
      mode_color = "#8fbcbb" -- TERMINAL: Teal (Terminal Cyan)
    end

    if mode_name ~= last_mode_name then
      set_tmux_option("@vim_mode", mode_name)
      last_mode_name = mode_name
    end

    if mode_color ~= last_mode_color then
      set_tmux_option("@vim_mode_color", mode_color)
      last_mode_color = mode_color
    end
  end

  ---@return nil
  local function schedule_tmux_mode_update()
    if mode_update_timer == nil and uv ~= nil then
      mode_update_timer = uv.new_timer()
    end

    if mode_update_timer ~= nil then
      mode_update_timer:stop()
      mode_update_timer:start(40, 0, vim.schedule_wrap(update_tmux_mode))
      return
    end

    update_tmux_mode()
  end

  vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "*",
    callback = schedule_tmux_mode_update,
  })

  vim.api.nvim_create_autocmd("VimEnter", {
    callback = schedule_tmux_mode_update,
  })

  vim.api.nvim_create_autocmd("VimLeave", {
    ---@param _ev vim.api.keyset.create_autocmd.callback_args
    callback = function(_ev)
      if mode_update_timer ~= nil then
        mode_update_timer:stop()
        if not mode_update_timer:is_closing() then
          mode_update_timer:close()
        end
        mode_update_timer = nil
      end

      if last_mode_name ~= "" then
        set_tmux_option("@vim_mode", "")
      end
    end,
  })
end

---Native terminal toggle logic
---@type integer|nil
local term_buf = nil
---@type integer|nil
local term_win = nil

---@return nil
function M.toggle_terminal()
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    vim.api.nvim_win_hide(term_win)
    term_win = nil
  else
    -- Create terminal buffer if it doesn't exist or is invalid
    if not term_buf or not vim.api.nvim_buf_is_valid(term_buf) then
      term_buf = vim.api.nvim_create_buf(false, true)
    end

    -- Open the terminal window (split at bottom)
    vim.cmd("botright split")
    term_win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(term_win, term_buf)

    -- Optimize terminal window appearance
    vim.wo[term_win].number = false
    vim.wo[term_win].relativenumber = false
    vim.wo[term_win].signcolumn = "no"
    vim.wo[term_win].winblend = 0

    -- Start terminal if buffer is empty
    if vim.bo[term_buf].buftype ~= "terminal" then
      vim.fn.jobstart(vim.o.shell, { term = true })
    end

    vim.cmd("startinsert")
  end
end

---@return config.UtilModule
return M
