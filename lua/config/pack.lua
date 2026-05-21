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

  runtime.register_build_hooks(registry.builds)
  runtime.run_inits(modules)
  if registry.local_plugins then
    runtime.add_local_paths(registry.local_plugins)
  end

  vim.pack.add(registry.remote, {
    confirm = false,
    load = true,
  })

  runtime.run_setups(modules, failures)
  runtime.register_keymaps(modules)
  runtime.register_commands(failures)
  runtime.fire_very_lazy()
end

setup()
