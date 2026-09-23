local data_dir = vim.fn.stdpath("data")

---@param root string
---@return string
local function workspace_dir(root)
  local name = vim.fn.fnamemodify(root, ":t"):gsub("[^%w._-]", "_")
  if name == "" then
    name = "workspace"
  end
  return vim.fs.joinpath(data_dir, "jdtls-workspace", name .. "-" .. vim.fn.sha256(root):sub(1, 12))
end

---@type vim.lsp.Config
return {
  filetypes = { "java" },
  root_markers = { "build.gradle", "pom.xml", "settings.gradle" },
  cmd = { "jdtls" },
  before_init = function(_, config)
    local root = config.root_dir or vim.fn.getcwd()
    local command = {
      "jdtls",
      "-data",
      workspace_dir(root),
    }

    local platform = vim.fn.has("macunix") == 1 and "config_mac" or "config_linux"
    local configuration = vim.fs.joinpath(data_dir, "mason", "packages", "jdtls", platform)
    if vim.fn.isdirectory(configuration) == 1 then
      vim.list_extend(command, { "-configuration", configuration })
    end

    config.cmd = command
  end,
}
