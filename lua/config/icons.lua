-- Set icons for diagnostics and various plugins

---@alias config.DapIconSpec string|string[]

---@class config.IconsModule
---@field dap table<string, config.DapIconSpec>
---@field diagnostics table<string, string>
---@field kinds table<string, string>

---@type config.IconsModule
local M = {}

---@type table<string, config.DapIconSpec>
M.dap = {
  Breakpoint = "",
  BreakpointCondition = { "", "DiagnosticWarn" },
  BreakpointRejected = { "", "DiagnosticError" },
  LogPoint = "󰆈",
  Stopped = { "󰁕", "DiagnosticWarn", "DapStoppedLine" },
}

---@type table<string, string>
M.diagnostics = {
  Error = "",
  Warn = "",
  Info = "",
  Hint = "󰌵",
}

---@type table<string, string>
M.kinds = {
  Array = "󰅪",
  Boolean = "◩",
  Class = "󰠱",
  Color = "󰏘",
  Constant = "Ω", -- Omega for constants
  Constructor = "Σ", -- Sigma for constructors
  Enum = "τ", -- Tau for enums
  EnumMember = "τ",
  Event = "",
  Field = "ϕ", -- Phi for fields
  File = "󰈙",
  Folder = "󰉋",
  Function = "λ", -- Lambda for functions
  Interface = "Λ", -- Capital lambda for interface
  Key = "κ", -- Kappa for keys/keywords
  Keyword = "κ",
  Method = "∂", -- Partial derivative for methods
  Module = "⌬", -- Hexagon/benzene ring for modules
  Namespace = "Π", -- Pi for namespaces
  Null = "󰟢",
  Number = "󰎠",
  Object = "◈", -- Diamond for objects
  Operator = "󰆕",
  Package = "⌬",
  Property = "ϕ",
  Reference = "",
  Snippet = "⊂", -- Subset for snippet
  String = "",
  Struct = "Π",
  Text = "✎", -- Pencil for text
  TypeParameter = "󰊄",
  Unit = "",
  Value = "󰎠",
  Variable = "λ", -- Lambda for variables
}

---@return config.IconsModule
return M
