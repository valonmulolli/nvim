return {
  cmd = {
    "clangd",
    "--background-index",
    "--header-insertion=never",
    "--clang-tidy",
    "--completion-style=detailed",
    "--pch-storage=memory",
    "--query-driver=/usr/bin/gcc,/usr/bin/g++,/usr/bin/clang,/usr/bin/clang++",
  },

  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },

  root_markers = {
    "compile_commands.json",
    "compile_flags.txt",
    ".clangd",
    "Kbuild",
    ".git",
  },
}
