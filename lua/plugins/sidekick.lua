local M = {}

---@return string|nil
local function sidekick_nes_jump_or_apply()
  if not require("sidekick").nes_jump_or_apply() then
    return "<Tab>"
  end
  return nil
end

---@return nil
local function sidekick_toggle_focus()
  require("sidekick.cli").toggle({ focus = true })
end

---@return nil
local function sidekick_toggle()
  require("sidekick.cli").toggle()
end

---@return nil
local function sidekick_select_tool()
  require("sidekick.cli").select({ filter = { installed = true } })
end

---@return nil
local function sidekick_detach()
  require("sidekick.cli").close()
end

---@return nil
local function sidekick_send_this()
  require("sidekick.cli").send({ msg = "{this}" })
end

---@return nil
local function sidekick_send_file()
  require("sidekick.cli").send({ msg = "{file}" })
end

---@return nil
local function sidekick_send_selection()
  require("sidekick.cli").send({ msg = "{selection}" })
end

---@return nil
local function sidekick_prompt()
  require("sidekick.cli").prompt()
end

---@return nil
local function sidekick_toggle_opencode()
  require("sidekick.cli").toggle({ name = "opencode", focus = true })
end

---@return nil
local function sidekick_toggle_claude()
  require("sidekick.cli").toggle({ name = "claude", focus = true })
end

---@return nil
local function sidekick_request_suggestions()
  require("sidekick.nes").update()
end

---@return nil
local function sidekick_clear_suggestions()
  require("sidekick.nes").clear()
end

---@class plugins.SidekickOpts
---@field cli table<string, any>
---@field nes table<string, any>
---@field signs table<string, any>

---@type plugins.SidekickOpts
local opts = {
  cli = {
    -- NO tmux/zellij - uses Neovim terminal
    mux = {
      enabled = false, -- Disabled: sessions run in Neovim terminal
    },

    -- Auto reload files if modified by AI tool
    watch = true,

    -- Window configuration
    win = {
      layout = "right", -- "float" | "left" | "bottom" | "top" | "right"
      split = {
        width = 80, -- used to be 80
        height = 20,
      },
    },

    -- Pre-configured CLI tools (use what you have installed)
    tools = {
      opencode = {
        cmd = { "opencode" },
        env = { OPENCODE_THEME = "system" },
      },
      kilo = { cmd = { "kilo" } },
      claude = { cmd = { "claude" } },
      gemini = { cmd = { "gemini" } },
      codex = { cmd = { "codex", "--enable", "web_search_request" } },
    },

    -- Prompt library
    prompts = {
      explain = "Explain {this}",
      fix = "Can you fix {this}?",
      tests = "Can you write tests for {this}?",
      refactor = "Please refactor {this} for better maintainability",
      review = "Can you review {file} for any issues or improvements?",
      optimize = "How can {this} be optimized?",
    },

    -- Use snacks for picker
    picker = "snacks",
  },

  -- Next Edit Suggestions (NES) - powered by Copilot
  nes = {
    enabled = true,
    debounce = 100,
    diff = {
      inline = "words",
    },
  },

  -- Visual indicators
  signs = {
    enabled = true,
    icon = " ",
  },
}

M.keys = {
  -- Tab: Navigate/apply next edit suggestions
  {
    "<tab>",
    sidekick_nes_jump_or_apply,
    expr = true,
    mode = { "n" },
    desc = "Goto/Apply Next Edit Suggestion",
  },

  -- Toggle CLI
  {
    "<C-.>",
    sidekick_toggle_focus,
    desc = "Sidekick: Toggle & Focus",
    mode = { "n", "t", "i", "x" },
  },
  {
    "<leader>aa",
    sidekick_toggle,
    desc = "Sidekick: Toggle CLI",
  },
  {
    "<leader>as",
    sidekick_select_tool,
    desc = "Sidekick: Select CLI Tool",
  },
  {
    "<leader>ad",
    sidekick_detach,
    desc = "Sidekick: Detach CLI Session",
  },

  -- Send context
  {
    "<leader>at",
    sidekick_send_this,
    mode = { "n", "x" },
    desc = "Sidekick: Send Current Context",
  },
  {
    "<leader>af",
    sidekick_send_file,
    desc = "Sidekick: Send Current File",
  },
  {
    "<leader>av",
    sidekick_send_selection,
    mode = { "x" },
    desc = "Sidekick: Send Visual Selection",
  },

  -- Prompts
  {
    "<leader>ap",
    sidekick_prompt,
    mode = { "n", "x" },
    desc = "Sidekick: Prompt Picker",
  },

  -- Quick tool toggles
  {
    "<leader>ao",
    sidekick_toggle_opencode,
    desc = "Sidekick: Toggle OpenCode",
  },
  {
    "<leader>ac",
    sidekick_toggle_claude,
    desc = "Sidekick: Toggle Claude",
  },

  -- NES controls
  {
    "<leader>an",
    sidekick_request_suggestions,
    desc = "Sidekick: Request New Suggestions",
  },
  {
    "<leader>ax",
    sidekick_clear_suggestions,
    desc = "Sidekick: Clear Suggestions",
  },
}

function M.setup()
  require("sidekick").setup(opts)
end

return M
