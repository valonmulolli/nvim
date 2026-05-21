local M = {}
local paths = require("config.paths")

M.keys = {
      { "<leader>r", ":RunFile<CR>", mode = "n", desc = "Run file" },
      { "<leader>rf", ":RunFile<CR>", mode = "n", desc = "Run file" },

      -- Build command picker
      { "<leader>rb", ":RunBuildSelect<CR>", mode = "n", desc = "Select build command" },
      { "<leader>rl", ":RunLive<CR>", mode = "n", desc = "Run live/watch command" },

      -- Output modes
      { "<leader>rt", ":RunFile tab<CR>", mode = "n", desc = "Run file in new tab" },
      { "<leader>rv", ":RunFile vsplit<CR>", mode = "n", desc = "Run file in vertical split" },
      { "<leader>rh", ":RunFile split<CR>", mode = "n", desc = "Run file in horizontal split" },

      -- Control
      { "<leader>rq", ":RunClose<CR>", mode = "n", desc = "Close runner" },
      { "<leader>rs", ":StopCode<CR>", mode = "n", desc = "Stop execution" },
}

function M.setup()
      require("zignite").setup({
        -- Keymaps are managed by Lazy's `keys` above.
        keymaps = {},

        -- ====================================================================
        -- OUTPUT MODE
        -- ====================================================================
        mode = "float",

        -- ====================================================================
        -- FILETYPE RUNNERS
        -- ====================================================================
        runners = {
          -- Compiled languages
          c = {
            cmd = {
              "gcc -pipe $file -o /tmp/$fileNameWithoutExt",
              "/tmp/$fileNameWithoutExt",
            },
            cleanup_command = "rm -f /tmp/$fileNameWithoutExt",
          },
          cpp = {
            cmd = {
              "g++ -pipe $file -o /tmp/$fileNameWithoutExt",
              "/tmp/$fileNameWithoutExt",
            },
            cleanup_command = "rm -f /tmp/$fileNameWithoutExt",
          },
          rust = {
            cmd = {
              "cd $dir",
              "rustc $fileName -o /tmp/$fileNameWithoutExt",
              "/tmp/$fileNameWithoutExt",
            },
            cleanup_command = "rm /tmp/$fileNameWithoutExt",
          },
          go = "go run $file",
          zig = "zig run $file",
          java = {
            cmd = {
              "cd $dir",
              "javac $fileName",
              "java $fileNameWithoutExt",
            },
            cleanup_command = "rm -f $dir/$fileNameWithoutExt*.class",
          },
          kotlin = {
            cmd = {
              "cd $dir",
              "kotlinc $fileName -include-runtime -d /tmp/$fileNameWithoutExt.jar",
              "java -jar /tmp/$fileNameWithoutExt.jar",
            },
            cleanup_command = "rm /tmp/$fileNameWithoutExt.jar",
          },

          -- Interpreted languages
          python = "python3 -u $file",
          javascript = "node $file",
          typescript = "bun $file",
          lua = "lua $file",
          ruby = "ruby $file",
          php = "php $file",
          perl = "perl $file",
          r = "Rscript $file",
          julia = "julia $file",

          -- Shell scripts
          sh = "bash $file",
          zsh = "zsh $file",

          -- Web and markup
          html = "xdg-open $file",

          -- Other languages
          dart = "dart run $file",
          swift = "swift $file",
          elixir = "elixir $file",
          haskell = {
            cmd = {
              "cd $dir",
              "ghc -o /tmp/$fileNameWithoutExt $fileName",
              "/tmp/$fileNameWithoutExt",
            },
            cleanup_command = "rm /tmp/$fileNameWithoutExt",
          },
          odin = "odin run $file -file",
          fortran = {
            cmd = {
              "cd $dir",
              "gfortran $fileName -o /tmp/$fileNameWithoutExt",
              "/tmp/$fileNameWithoutExt",
            },
            cleanup_command = "rm /tmp/$fileNameWithoutExt",
          },
        },

        -- ====================================================================
        -- BUILD COMMANDS (NEW!)
        -- ====================================================================
        build_commands = {
          -- Rust
          rust = {
            build = "cargo build",
            run = "cargo run",
            test = "cargo test",
            release = "cargo build --release",
            ["release-run"] = "cargo run --release",
            check = "cargo check",
            clean = "cargo clean",
          },

          -- Zig
          zig = {
            build = "zig build",
            run = "zig build run",
            test = "zig build test",
            release = "zig build -Doptimize=ReleaseFast",
            ["release-run"] = "zig build run -Doptimize=ReleaseFast",
            fetch = "zig fetch $zignite_args",
          },

          -- Go
          go = {
            build = "go build",
            run = "go run .",
            test = "go test ./...",
            clean = "go clean",
            mod = "go mod tidy",
          },

          -- Odin
          odin = {
            build = "odin build .",
            run = "odin run .",
            test = "odin test .",
            release = "odin build . -o:speed",
            check = "odin check .",
          },

          -- Fortran
          fortran = {
            build = "gfortran *.f90 -o main",
            run = "./main",
            clean = "rm -f main",
          },

          -- JavaScript/TypeScript
          javascript = {
            start = "npm start",
            dev = "npm run dev",
            build = "npm run build",
            test = "npm test",
            install = "npm install",
          },

          typescript = {
            start = "npm start",
            dev = "npm run dev",
            build = "npm run build",
            test = "npm test",
          },

          -- Python
          python = {
            run = "python -m main",
            test = "pytest",
            install = "pip install -r requirements.txt",
          },

          -- C/C++ with Make, CMake, and Meson
          c = {
            -- Make
            build = "make",

            -- CMake
            ["cmake-config"] = "cmake -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=1",
            ["cmake-build"] = "cmake --build build",
            ["cmake-run"] = "cmake --build build && ./build/main",
            ["cmake-clean"] = "cmake --build build --target clean",
            ["cmake-debug"] = "cmake -B build -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=1 && cmake --build build",
            ["cmake-release"] = "cmake -B build -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=1 && cmake --build build",

            -- Meson
            ["meson-setup"] = "meson setup build",
            ["meson-build"] = "meson compile -C build",
            ["meson-run"] = "meson compile -C build && ./build/main",
            ["meson-clean"] = "meson compile -C build --clean",
            ["meson-test"] = "meson test -C build",
          },

          cpp = {
            -- Make
            build = "make",

            -- CMake
            ["cmake-config"] = "cmake -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=1",
            ["cmake-build"] = "cmake --build build",
            ["cmake-run"] = "cmake --build build && ./build/main",
            ["cmake-clean"] = "cmake --build build --target clean",
            ["cmake-debug"] = "cmake -B build -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=1 && cmake --build build",
            ["cmake-release"] = "cmake -B build -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=1 && cmake --build build",
            ["cmake-test"] = "ctest --test-dir build",

            -- Meson
            ["meson-setup"] = "meson setup build",
            ["meson-build"] = "meson compile -C build",
            ["meson-run"] = "meson compile -C build && ./build/main",
            ["meson-clean"] = "meson compile -C build --clean",
            ["meson-test"] = "meson test -C build",
          },
        },

        -- ====================================================================
        -- ANIMATIONS & OUTPUT
        -- ====================================================================
        spinner = "dots",
        spinner_speed = 80,
        enable_animations = true,

        -- Execution configuration
        timeout = nil, -- Timeout in ms (e.g. 5000). nil = disabled.

        -- Output configuration
        show_stderr_prefix = false,
        no_stderr_prefix_types = { "zig", "go", "rust" },

        -- Quickfix / diagnostics performance
        quickfix = {
          enabled = true,
          processor = "auto",
          zig_min_lines = 300,
          max_lines = 1000,
          max_bytes = 262144,
          strip_ansi = true,
          strip_ansi_max_lines = 400,
          parse_diagnostics = true,
          zig_worker = true,
          async_strip = true,
          strip_chunk_size = 200,
        },

        -- Build command auto-detection (keep smart behavior enabled by default)
        detect = {
          zig = true,
          go = true,
          rust = true,
          odin = true,
          c_cpp_make = true,
          js_package_scripts = true,
          java_kotlin_project = true,
          bazel_project = true,
        },

        -- Stderr filtering (NEW!)
        stderr_filters = {
          "MODULE_TYPELESS_PACKAGE_JSON", -- Node.js module warnings
          "ExperimentalWarning", -- Experimental features
          "DeprecationWarning", -- Deprecations
          "Use `node --trace-warnings", -- Trace suggestions
          "To eliminate this warning", -- Warning hints
        },

        -- ====================================================================
        -- PROJECT CONFIGURATION
        -- ====================================================================
        project = {
          -- Add your custom projects here
          -- Example:
          -- [vim.fs.joinpath(paths.dev_root, "myproject") .. "/.*"] = {
          --   name = "My Project",
          --   command = "cargo run --release",
          -- },
        },

        -- ====================================================================
        -- UI CONFIGURATION
        -- ====================================================================
        float = {
          border = "rounded",
          height = 0.15,
          width = 0.60,
          x = 1,
          y = 0.90,
          border_hl = "FloatBorder",
          close_key = "q",
          auto_close_success_ms = nil,
          focus = true,
          startinsert = true,
        },

        term = {
          position = "bot",
          size = 5,
          focus = true,
          startinsert = true,
        },

        picker = {
          focus = true,
          filter_input = "inline",
        },
      })

      -- No language-specific keymaps
end

return M
