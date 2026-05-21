local ok, local_config = pcall(require, "config.local")
if ok then
  return local_config
end

local home = vim.env.HOME or vim.fn.expand("~")
return {
  home = home,
  dev_root = vim.fs.joinpath(home, "Dev"),
  sql_root = vim.fs.joinpath(home, "Sql"),
}
