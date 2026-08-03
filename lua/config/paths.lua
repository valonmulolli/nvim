local ok, local_config = pcall(require, "config.local")
if ok then
  return local_config
end

local home = vim.env.HOME or vim.fn.expand("~")
local dev_root = vim.fs.joinpath(home, "Dev")
return {
  home = home,
  dev_root = dev_root,
  sql_root = vim.fs.joinpath(home, "Sql"),
  plugins = {
    zignite = vim.fs.joinpath(dev_root, "work", "zignite.nvim"),
    heap = vim.fs.joinpath(dev_root, "heap-themes", "heap-nvim"),
  },
}
