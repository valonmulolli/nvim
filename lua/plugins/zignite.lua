local M = {}

M.keys = {
  { "<leader>r", ":RunFile<CR>", mode = "n", desc = "Run file" },
  { "<leader>rf", ":RunFile<CR>", mode = "n", desc = "Run file" },
  { "<leader>rb", ":RunBuildSelect<CR>", mode = "n", desc = "Select build command" },
  { "<leader>rl", ":RunLive<CR>", mode = "n", desc = "Run live/watch command" },
  { "<leader>rt", ":RunFile tab<CR>", mode = "n", desc = "Run file in new tab" },
  { "<leader>rv", ":RunFile vsplit<CR>", mode = "n", desc = "Run file in vertical split" },
  { "<leader>rh", ":RunFile split<CR>", mode = "n", desc = "Run file in horizontal split" },
  { "<leader>rq", ":RunClose<CR>", mode = "n", desc = "Close runner" },
  { "<leader>rs", ":StopCode<CR>", mode = "n", desc = "Stop execution" },
}

function M.setup()
  require("zignite").setup({
    keymaps = {},
    mode = "float",

    runners = {},
    build_commands = {},

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

    detect_runtime = {
      async_picker = true,
      cache_ttl_ms = 15000,
      live_merge = true,
    },

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

    project = {},

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
      layout = "auto",
      compact_breakpoint = 96,
    },

    spinner = "dots",
    spinner_speed = 80,
    enable_animations = true,

    singleton = true,
    close_behavior = "stop",

    timeout = nil,
  })
end

return M
