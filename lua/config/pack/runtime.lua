---@class config.PackRuntimeModule
---@field load_modules fun(module_names: string[]): table[], string[]
---@field run_inits fun(modules: table[]): nil
---@field run_setups fun(modules: table[], failures: string[]): nil
---@field add_local_paths fun(entries: table[]): nil
---@field register_keymaps fun(modules: table[]): nil
---@field register_build_hooks fun(builds: table<string, string|function>): nil
---@field register_commands fun(failures: string[]): nil
---@field fire_very_lazy fun(): nil

---@type config.PackRuntimeModule
local M = {}

---@type table<string, boolean>
local did_register_build_hooks = {}

function M.load_modules(module_names)
  ---@type table[]
  local modules = {}
  ---@type string[]
  local failures = {}

  for _, module_name in ipairs(module_names) do
    ---@type boolean, any
    local ok, loaded = pcall(require, module_name)
    if ok and type(loaded) == "table" then
      modules[#modules + 1] = loaded
    else
      failures[#failures + 1] = string.format("failed to load %s: %s", module_name, tostring(loaded))
    end
  end

  return modules, failures
end

function M.run_inits(modules)
  for _, module in ipairs(modules) do
    if type(module.init) == "function" then
      pcall(module.init)
    end
  end
end

function M.run_setups(modules, failures)
  for _, module in ipairs(modules) do
    if type(module.setup) == "function" then
      ---@type boolean, any
      local ok, err = pcall(module.setup)
      if not ok then
        failures[#failures + 1] = tostring(err)
      end
    end
  end
end

function M.add_local_paths(entries)
  for _, entry in ipairs(entries) do
    if vim.fn.isdirectory(entry.path) == 1 then
      vim.opt.rtp:prepend(entry.path)

      ---@type string
      local after = vim.fs.joinpath(entry.path, "after")
      if vim.fn.isdirectory(after) == 1 then
        vim.opt.rtp:append(after)
      end

      if entry.build then
        if type(entry.build) == "function" then
          pcall(entry.build, entry.path)
        else
          vim.system({ vim.o.shell, vim.o.shellcmdflag, entry.build }, { cwd = entry.path }, function(obj)
            if obj.code ~= 0 then
              vim.schedule(function()
                vim.notify(
                  string.format("Build failed for %s:\n%s", entry.name, (obj.stderr ~= "" and obj.stderr or obj.stdout)),
                  vim.log.levels.ERROR
                )
              end)
            end
          end)
        end
      end
    end
  end
end

function M.register_keymaps(modules)
  for _, module in ipairs(modules) do
    for _, keymap in ipairs(module.keys or {}) do
      ---@type string|nil
      local lhs = keymap[1]
      ---@type string|function|nil
      local rhs = keymap[2]
      if lhs ~= nil and rhs ~= nil then
        ---@type vim.keymap.set.Opts
        local opts = {}
        for key, value in pairs(keymap) do
          if type(key) ~= "number" then
            opts[key] = value
          end
        end

        ---@type string|string[]
        local mode = opts.mode or "n"
        opts.mode = nil

        ---@type string|string[]|nil
        local filetype = opts.ft
        opts.ft = nil

        if filetype ~= nil then
          vim.api.nvim_create_autocmd("FileType", {
            pattern = filetype,
            callback = function(ev)
              opts.buf = ev.buf
              vim.keymap.set(mode, lhs, rhs, opts)
            end,
          })
        else
          vim.keymap.set(mode, lhs, rhs, opts)
        end
      end
    end
  end
end

function M.register_build_hooks(builds)
  for name in pairs(builds) do
    if did_register_build_hooks[name] then
      builds[name] = nil
    else
      did_register_build_hooks[name] = true
    end
  end

  if vim.tbl_isempty(builds) then
    return
  end

  vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
      ---@type string
      local kind = ev.data.kind
      if kind ~= "install" and kind ~= "update" then
        return
      end

      ---@type string|function|nil
      local build = builds[ev.data.spec.name]
      if build == nil then
        return
      end

      if type(build) == "function" then
        pcall(build, ev.data.path)
        return
      end

      if build:sub(1, 1) == ":" then
        if not ev.data.active then
          pcall(vim.cmd.packadd, ev.data.spec.name)
        end
        pcall(vim.cmd, build:sub(2))
        return
      end

      vim.system({ vim.o.shell, vim.o.shellcmdflag, build }, { cwd = ev.data.path }, function(obj)
        if obj.code ~= 0 then
          vim.schedule(function()
            vim.notify(
              string.format("Build failed for %s:\n%s", ev.data.spec.name, (obj.stderr ~= "" and obj.stderr or obj.stdout)),
              vim.log.levels.ERROR
            )
          end)
        end
      end)
    end,
  })
end

function M.register_commands(failures)
  vim.api.nvim_create_user_command("PackUpdate", function(command)
    vim.pack.update(nil, { force = command.bang })
  end, {
    bang = true,
    desc = "Update vim.pack managed plugins",
  })

  vim.api.nvim_create_user_command("PackStatus", function()
    vim.pack.update(nil, { offline = true })
  end, {
    desc = "Show vim.pack plugin status",
  })

  if #failures > 0 then
    vim.schedule(function()
      vim.notify("vim.pack config issues:\n" .. table.concat(failures, "\n"), vim.log.levels.WARN)
    end)
  end
end

function M.fire_very_lazy()
  vim.schedule(function()
    vim.api.nvim_exec_autocmds("User", { pattern = "VeryLazy" })
  end)
end

return M
