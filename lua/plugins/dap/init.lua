-- nvim-dap | Debug Adapter Protocol client implementation for neovim
-- https://github.com/mfussenegger/nvim-dap

---@type LazyPluginSpec[]
return {
  { -- Debug adapter protocol client
    "mfussenegger/nvim-dap",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "DapContinue", "DapToggleBreakpoint" },
    dependencies = {
      -- A library for asynchronous IO in Neovim
      { "nvim-neotest/nvim-nio" },
      -- bridges mason.nvim with the nvim-dap
      { "jay-babu/mason-nvim-dap.nvim" },
      -- Debug adapter for Neovim plugins
      { "jbyuki/one-small-step-for-vimkind" },
    },
    -- stylua: ignore
    keys = {
      { "<F3>",       function() require("dap").repl.toggle({ height = 40 }) end,                           desc = "Toggle REPL" },
      { "<F4>",       function() require("dap").terminate() end,                                            desc = "Terminate" },
      { "<F5>",       function() require("dap").continue() end,                                             desc = "Continue" },
      { "<F6>",       function() require("dap").pause() end,                                                desc = "Pause" },
      { "<F9>",       function() require("dap").toggle_breakpoint() end,                                    desc = "Set breakpoint" },
      { "<F10>",      function() require("dap").step_over() end,                                            desc = "Step over" },
      { "<F11>",      function() require("dap").step_into() end,                                            desc = "Step into" },
      { "<F14>",      function() require("dap").step_out() end,                                             desc = "Step out" },
      { "<leader>vB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Breakpoint condition" },
      { "<leader>vb", function() require("dap").toggle_breakpoint() end,                                    desc = "Set breakpoint" },
      { "<leader>vc", function() require("dap").continue() end,                                             desc = "Continue" },
      { "<leader>vC", function() require("dap").run_to_cursor() end,                                        desc = "Run to cursor" },
      { "<leader>ve", function() require("dap").set_exception_breakpoints() end,                            desc = "Exception breakpoint" },
      { "<leader>vg", function() require("dap").goto_() end,                                                desc = "Go to line (no execute)" },
      { "<leader>vh", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
      { "<leader>vi", function() require("dap").step_into() end,                                            desc = "Step into" },
      { "<leader>vj", function() require("dap").down() end,                                                 desc = "Down" },
      { "<leader>vk", function() require("dap").up() end,                                                   desc = "Up" },
      { "<leader>vl", function() require("dap").run_last() end,                                             desc = "Run last" },
      {
        "<leader>vL",
        function()
          require("dap").toggle_breakpoint(nil, nil,
            vim.fn.input("Log point message: "), true)
        end,
        desc = "Set log breakpoint"
      },
      { "<leader>vN", function() require("dap").step_back() end,                  desc = "Step back" },
      { "<leader>vO", function() require("dap").step_out() end,                   desc = "Step out" },
      { "<leader>vo", function() require("dap").step_over() end,                  desc = "Step over" },
      { "<leader>vp", function() require("dap").pause() end,                      desc = "Pause" },
      { "<leader>vr", function() require("dap").repl.toggle({ height = 40 }) end, desc = "Toggle REPL" },
      { "<leader>vs", function() require("dap").session() end,                    desc = "Session" },
      { "<leader>vt", function() require("dap").terminate() end,                  desc = "Terminate" },
      { "<leader>vw", function() require("dap.ui.widgets").hover() end,           desc = "Widgets" },
    },
    config = function()
      -- Set default highlights
      vim.api.nvim_set_hl(0, "DapBreakpoint", { default = true, link = "Error" })
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      -- Set custom sign icons
      local icons = require("config.icons").dap
      for name, sign in pairs(icons) do
        sign = type(sign) == "table" and sign or { sign }
        name = "Dap" .. name
        local text = sign[1] .. " "
        local texthl = sign[4] or name
        vim.fn.sign_define(name, { text = text, texthl = texthl, linehl = sign[3], numhl = sign[3] })
      end

      -- Load adapters/config from settings directory
      vim.cmd("runtime! lua/plugins/dap/adapters/*.lua")
      require("dap.ext.vscode").load_launchjs()
    end,
  },
  { -- Fancy UI for the debugger
    "rcarriga/nvim-dap-ui",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "DapContinue", "DapToggleBreakpoint" },
    dependencies = { "mfussenegger/nvim-dap" },
    -- stylua: ignore
    keys = {
      { "<leader>ve", function() require("dapui").eval() end,                             desc = "Eval",           mode = { "n", "v" } },
      { "<leader>vE", function() require("dapui").eval(vim.fn.input("expression: ")) end, desc = "Eval Expression" },
      { "<leader>vu", function() require("dapui").toggle({ reset = true }) end,           desc = "Dap UI" },
    },
    opts = {
      expand_lines = false,
      floating = { border = vim.g.border },
      mappings = { expand = { "<TAB>", "<CR>", "<4-LeftMouse>" } },
      layouts = {
        {
          elements = {
            { id = "scopes",      size = 0.45 },
            { id = "breakpoints", size = 0.45 },
            { id = "stacks",      size = 0.45 },
            { id = "watches",     size = 0.45 },
          },
          position = "right",
          size = 40,
        },
        {
          elements = {
            { id = "repl",    size = 0.5 },
            { id = "console", size = 0.5 },
          },
          position = "bottom",
          size = 0.45,
        },
      },
    },
    config = function(_, opts)
      require("dapui").setup(opts)
      require("plugins.dap.ui")
    end,
  },
  { -- virtual text for the debugger
    "theHamsta/nvim-dap-virtual-text",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "DapContinue", "DapToggleBreakpoint" },
    dependencies = { "mfussenegger/nvim-dap" },
    opts = {
      show_stop_reason = false,
    },
  },
  { -- Integration for nvim-dap with telescope.nvim
    "nvim-telescope/telescope-dap.nvim",
    cmd = { "DapContinue", "DapToggleBreakpoint", "Telescope" },
    dependencies = {
      -- Debug adapter protocol client
      "mfussenegger/nvim-dap",
      -- A highly extendable fuzzy finder for neovim
      "nvim-telescope/telescope.nvim",
    },
    -- stylua: ignore
    keys = {
      { "<F5>",       function() require("dap").continue() end, desc = "Continue" },
      { "<leader>vc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>vd", "<cmd>Telescope dap commands<CR>",        desc = "Commands" },
      { "<leader>vv", "<cmd>Telescope dap variables<CR>",       desc = "Variables" },
    },
    config = function()
      require("telescope").load_extension("dap")
    end,
  },
}
