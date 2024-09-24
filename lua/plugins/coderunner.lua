return 
  {
    "CRAG666/code_runner.nvim",
    event = "VeryLazy",
    config = function()
      require("code_runner").setup {
        filetype = {
          java = {
            "cd $dir &&",
            "javac $fileName &&",
            "java $fileNameWithoutExt",
          },
          javascript = "node",
          c = {
            "cd $dir &&",
            "gcc $fileName -o",
            "/tmp/$fileNameWithoutExt &&",
            "/tmp/$fileNameWithoutExt &&",
            "rm /tmp/$fileNameWithoutExt",
          },
          cpp = {
            "cd $dir &&",
            "g++ $fileName",
            "-o /tmp/$fileNameWithoutExt &&",
            "/tmp/$fileNameWithoutExt",
          },
          go = {
            "cd $dir &&",
            "go run $fileName",
          },
          python = "python -u '$dir/$fileName'",
          sh = "bash",
          typescript = "deno run",
          typescriptreact = "yarn dev$end",
          rust = "cd $dir && rustc $fileName && $dir$fileNameWithoutExt",
        },
      }
    end,
  }