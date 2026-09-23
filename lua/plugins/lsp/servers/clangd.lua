local drivers = {}
for _, compiler in ipairs({ "gcc", "g++", "clang", "clang++" }) do
  local path = vim.fn.exepath(compiler)
  if path ~= "" then
    drivers[#drivers + 1] = path
  end
end

local cmd = {
    "clangd",
    "--background-index",
    "--header-insertion=never",
    "--clang-tidy",
    "--completion-style=detailed",
    "--pch-storage=memory",
  }
if #drivers > 0 then
  cmd[#cmd + 1] = "--query-driver=" .. table.concat(drivers, ",")
end

return {
  cmd = cmd,

  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },

  root_markers = {
    "compile_commands.json",
    "compile_flags.txt",
    ".clangd",
    "Kbuild",
    ".git",
  },
}
