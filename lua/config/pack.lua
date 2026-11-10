local registry = require("config.pack.plugins")
local runtime = require("config.pack.runtime")

---@type boolean
local did_setup = false

---@return nil
local function setup()
  if did_setup then
    return
  end
  did_setup = true

  ---@type table[]
  local modules, failures = runtime.load_modules(registry.modules)

  runtime.register_build_hooks(registry.builds, failures)
  runtime.run_inits(modules, failures)
  if registry.local_plugins then
    runtime.add_local_paths(registry.local_plugins, failures)
  end

  -- Keep vim.pack's forced progress redraw out of the command line while it
  -- installs; embedded UIs can resize during that redraw and hit a grid assert.
  local original_messagesopt = vim.o.messagesopt
  local message_options = vim.split(original_messagesopt, ",", { trimempty = true })
  for index = #message_options, 1, -1 do
    if message_options[index]:match("^progress:") then
      table.remove(message_options, index)
    end
  end
  local install_messagesopt = table.concat(message_options, ",")
  if install_messagesopt ~= original_messagesopt then
    vim.o.messagesopt = install_messagesopt
  end

  local ok, err = pcall(vim.pack.add, registry.remote, {
    confirm = false,
    load = true,
  })
  if not ok then
    vim.o.messagesopt = original_messagesopt
    error(err)
  end

  if install_messagesopt ~= original_messagesopt then
    vim.schedule(function()
      if vim.o.messagesopt == install_messagesopt then
        vim.o.messagesopt = original_messagesopt
      end
    end)
  end

  runtime.run_setups(modules, failures)
  runtime.register_keymaps(modules)
  runtime.register_commands(failures)
  runtime.fire_very_lazy()
end

setup()
