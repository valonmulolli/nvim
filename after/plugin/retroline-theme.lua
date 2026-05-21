local function get_hl(name)
  local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = true })
  if ok and type(hl) == "table" then
    return hl
  end
  return {}
end

local function fg_of(name, fallback)
  local hl = get_hl(name)
  if type(hl.fg) == "number" then
    return hl.fg
  end
  return fallback
end

local function apply_retroline_theme()
  local statusline = get_hl("StatusLine")
  local normal = get_hl("Normal")
  local transparent = false

  local ok, state = pcall(require, "retroline.state")
  if ok and type(state) == "table" and type(state.runtime) == "table" then
    local statusline_opts = state.runtime.config and state.runtime.config.statusline or nil
    if type(statusline_opts) == "table" and statusline_opts.transparent == true then
      transparent = true
    end
  end

  local bar_fg = statusline.fg or normal.fg or 0xC0C0C0
  local bar_bg = transparent and "NONE" or (statusline.bg or normal.bg or "NONE")
  local normal_bg = transparent and "NONE" or (normal.bg or bar_bg)

  vim.api.nvim_set_hl(0, "RetrolinePath", {
    fg = bar_fg,
    bg = bar_bg,
  })

  vim.api.nvim_set_hl(0, "RetrolineAnim", {
    fg = fg_of("Special", bar_fg),
    bg = bar_bg,
    bold = true,
  })

  vim.api.nvim_set_hl(0, "RetrolineMuted", {
    fg = fg_of("Comment", bar_fg),
    bg = bar_bg,
  })

  vim.api.nvim_set_hl(0, "RetrolineModeNormal", {
    fg = fg_of("StatusLine", bar_fg),
    bg = bar_bg,
    bold = true,
  })

  vim.api.nvim_set_hl(0, "RetrolineModeInsert", {
    fg = fg_of("String", bar_fg),
    bg = bar_bg,
    bold = true,
  })

  vim.api.nvim_set_hl(0, "RetrolineModeVisual", {
    fg = fg_of("Type", bar_fg),
    bg = bar_bg,
    bold = true,
  })

  vim.api.nvim_set_hl(0, "RetrolineModeReplace", {
    fg = fg_of("DiagnosticError", bar_fg),
    bg = bar_bg,
    bold = true,
  })

  vim.api.nvim_set_hl(0, "RetrolineModeCommand", {
    fg = fg_of("Function", bar_fg),
    bg = bar_bg,
    bold = true,
  })

  vim.api.nvim_set_hl(0, "RetrolineModeTerminal", {
    fg = fg_of("Special", bar_fg),
    bg = bar_bg,
    bold = true,
  })

  vim.api.nvim_set_hl(0, "RetrolineDiagError", {
    fg = fg_of("DiagnosticError", 0xFF0000),
    bg = normal_bg,
    bold = true,
  })

  vim.api.nvim_set_hl(0, "RetrolineDiagWarn", {
    fg = fg_of("DiagnosticWarn", bar_fg),
    bg = normal_bg,
    bold = true,
  })

  vim.api.nvim_set_hl(0, "RetrolineDiagInfo", {
    fg = fg_of("DiagnosticInfo", bar_fg),
    bg = normal_bg,
  })

  vim.api.nvim_set_hl(0, "RetrolineDiagHint", {
    fg = fg_of("DiagnosticHint", bar_fg),
    bg = normal_bg,
  })

  vim.api.nvim_set_hl(0, "RetrolineDiagOk", {
    fg = fg_of("Comment", bar_fg),
    bg = normal_bg,
  })
end

apply_retroline_theme()
vim.schedule(apply_retroline_theme)

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.schedule(apply_retroline_theme)
  end,
})
