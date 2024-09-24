-- Pyright: Python Language-server configuration
-- https://github.com/microsoft/pyright
local exepath = vim.fn.exepath
local path = require("lspconfig.util").path

local function get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
  end

  -- Find and use virtualenv in workspace directory.
  for _, pattern in ipairs({ "*", ".*" }) do
    local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
    if match ~= "" then
      return path.join(path.dirname(match), "bin", "python")
    end
  end

  -- Fallback to system Python.
  return exepath("python3") or exepath("python") or "python"
end

-- Debugging: Print the Python path
print("Configured Python Path: ", get_python_path(vim.fn.getcwd()))

-- Use the VIRTUAL_ENV path if it exists else just use the system default
vim.g.python3_host_prog = get_python_path()

return {
  -- Configure the root directory for Pyright
  root_dir = function(fname)
    return require 'lspconfig'.util.find_git_ancestor(fname) or path.dirname(fname)
  end,

  -- cmd = { pyright_binary, '--stdio' },
  on_init = function(client)
    client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
  end,

  analysis = {
    -- Search subdirectories like src; defaults to true
    autoSearchPaths = true,
    -- Make completion a lot faster; defaults to true
    useLibraryCodeForTypes = false,
  },
}
