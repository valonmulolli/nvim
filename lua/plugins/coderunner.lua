return {
  "CRAG666/code_runner.nvim",
  event = "VeryLazy",
  config = function()
    require("code_runner").setup {
      filetype = {
        c = {
          "cd $dir &&",
          "gcc $fileName -o /tmp/$fileNameWithoutExt &&",
          "/tmp/$fileNameWithoutExt &&",
          "rm /tmp/$fileNameWithoutExt",
        },
        cpp = {
          "cd $dir &&",
          "g++ $fileName -o /tmp/$fileNameWithoutExt &&",
          "/tmp/$fileNameWithoutExt",
        },
        java = {
          "cd $dir &&",
          "javac $fileName &&",
          "java $fileNameWithoutExt",
        },
        rust = {
          "cd $dir &&",
          "rustc $fileName &&",
          "./$fileNameWithoutExt"
        },
        go = {
          "cd $dir &&",
          "go run $fileName",
        },
        python = "python -u '$dir/$fileName'",
        javascript = "node $fileName",
        typescript = "bun $fileName",
        typescriptreact = "yarn dev$end",
        lua = "lua $fileName",
      },
    }
  end,
}
