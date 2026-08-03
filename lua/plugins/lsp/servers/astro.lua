local M = {}

local function find_typescript_lib(root)
  if not root or root == "" then
    return nil
  end

  local node_modules = vim.fs.find("node_modules", {
    path = root,
    upward = true,
    limit = math.huge,
  })

  for _, directory in ipairs(node_modules) do
    local lib = directory .. "/typescript/lib"
    if vim.uv.fs_stat(lib .. "/tsserverlibrary.js") or vim.uv.fs_stat(lib .. "/typescript.js") then
      return lib
    end
  end
end

local function find_mason_typescript_lib()
  local packages = vim.fn.stdpath("data") .. "/mason/packages"
  local candidates = vim.fn.glob(packages .. "/*/**/node_modules/typescript/lib", false, true)

  for _, lib in ipairs(candidates) do
    if vim.uv.fs_stat(lib .. "/tsserverlibrary.js") or vim.uv.fs_stat(lib .. "/typescript.js") then
      return lib
    end
  end
end

function M.setup()
  return {
    before_init = function(_, config)
      config.init_options = config.init_options or {}
      config.init_options.typescript = config.init_options.typescript or {}

      local tsdk = find_typescript_lib(config.root_dir) or find_mason_typescript_lib()
      if tsdk then
        config.init_options.typescript.tsdk = tsdk
        config.init_options.typescript.serverPath = tsdk .. "/tsserverlibrary.js"
      end
    end,
  }
end

return M.setup()
