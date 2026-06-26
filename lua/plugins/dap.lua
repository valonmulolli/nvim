---@return nil
local function dap_toggle_breakpoint()
  require("dap").toggle_breakpoint()
end

---@return nil
local function dap_set_breakpoint_condition()
  ---@type string
  local condition = vim.fn.input("Breakpoint condition: ")
  require("dap").set_breakpoint(condition)
end

---@return nil
local function dap_continue()
  require("dap").continue()
end

---@return nil
local function dap_run_to_cursor()
  require("dap").run_to_cursor()
end

---@return nil
local function dap_step_into()
  require("dap").step_into()
end

---@return nil
local function dap_step_over()
  require("dap").step_over()
end

---@return nil
local function dap_step_out()
  require("dap").step_out()
end

---@return nil
local function dap_pause()
  require("dap").pause()
end

---@return nil
local function dap_toggle_repl()
  require("dap").repl.toggle()
end

---@return nil
local function dap_show_session()
  require("dap").session()
end

---@return nil
local function dap_terminate()
  require("dap").terminate()
end

---@return nil
local function dapui_toggle()
  require("dapui").toggle()
end

---@return nil
local function dapui_eval()
  require("dapui").eval()
end

local M = {}

M.keys = {
  { "<leader>db", dap_toggle_breakpoint, desc = "Toggle Breakpoint" },
  { "<leader>dB", dap_set_breakpoint_condition, desc = "Conditional Breakpoint" },
  { "<leader>dc", dap_continue, desc = "Continue" },
  { "<leader>dC", dap_run_to_cursor, desc = "Run to Cursor" },
  { "<leader>di", dap_step_into, desc = "Step Into" },
  { "<leader>do", dap_step_over, desc = "Step Over" },
  { "<leader>dO", dap_step_out, desc = "Step Out" },
  { "<leader>dp", dap_pause, desc = "Pause" },
  { "<leader>dr", dap_toggle_repl, desc = "Toggle REPL" },
  { "<leader>ds", dap_show_session, desc = "Session" },
  { "<leader>dt", dap_terminate, desc = "Terminate" },
  { "<leader>du", dapui_toggle, desc = "Toggle DAP UI" },
  { "<leader>de", dapui_eval, desc = "Eval", mode = { "n", "v" } },
}

function M.setup()
  ---@type table<string, any>
  local dap = require("dap")
  ---@type table<string, any>
  local dapui = require("dapui")
  dapui.setup()

  ---@return string
  local function program_path()
    return vim.fn.input("path to exe: ", vim.fn.getcwd() .. "/build", "file")
  end

  ---@return string
  local function cwd_path()
    return vim.fn.input("cwd: ", vim.fn.getcwd() .. "/build", "file")
  end

  dap.adapters.codelldb = {
    type = "executable",
    port = "${port}",
    command = "codelldb",
    name = "codelldb",
    executable = {
      command = vim.env.HOME .. "/.local/share/nvim/mason/bin/codelldb",
      args = { "--port", "${port}" },
    },
  }

  dap.configurations.c = {
    {
      type = "codelldb",
      name = "codelldb",
      request = "launch",
      program = program_path,
      cwd = cwd_path,
      stopOnEntry = false,
    },
  }

  dap.configurations.cpp = dap.configurations.c
  dap.configurations.zig = dap.configurations.c

  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
  end
end

return M
