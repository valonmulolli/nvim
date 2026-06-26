local M = {}

---@class plugins.BlinkOpts
---@field keymap table<string, any>
---@field appearance table<string, any>
---@field sources table<string, any>
---@field snippets table<string, any>
---@field completion table<string, any>
---@field fuzzy table<string, any>

---@type plugins.BlinkOpts
local opts = {
  keymap = {
    preset = "none",
    -- ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-f>"] = { "hide" },
    ["<CR>"] = { "accept", "fallback" },
    ["<Tab>"] = {
      function(cmp)
        if cmp.snippet_active() then
          return cmp.accept()
        end
        return cmp.select_and_accept()
      end,
      "snippet_forward",
      "fallback",
    },
    ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    ["<Up>"] = { "select_prev", "fallback" },
    ["<Down>"] = { "select_next", "fallback" },
    ["<C-j>"] = { "select_next", "fallback" },
    ["<C-k>"] = { "select_prev", "fallback" },
    ["<C-u>"] = { "scroll_documentation_up", "fallback" },
    ["<C-d>"] = { "scroll_documentation_down", "fallback" },
  },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "mono",
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
    per_filetype = {
      c = { "lsp", "buffer", "path", "snippets" },
      cpp = { "lsp", "buffer", "path", "snippets" },
      zig = { "lsp", "buffer", "path", "snippets" },
      sql = { "dadbod", "lsp", "buffer", "snippets", "path" },
      markdown = { "buffer", "path", "snippets" },
      text = { "buffer", "path", "snippets" },
      json = { "lsp", "buffer", "path" },
      jsonc = { "lsp", "buffer", "path" },
    },
    ---@param ctx blink.cmp.Context
    ---@param items blink.cmp.CompletionItem[]
    ---@return blink.cmp.CompletionItem[]
    transform_items = function(ctx, items)
      ---@type table<string, integer>
      local kind = require("blink.cmp.types").CompletionItemKind
      ---@type integer
      local bufnr = ctx.bufnr or vim.api.nvim_get_current_buf()
      ---@type string
      local ft = vim.bo[bufnr].filetype
      ---@type table<string, boolean>
      local prefer_keyword = {
        c = true,
        cpp = true,
        zig = true,
        javascript = true,
        javascriptreact = true,
        typescript = true,
        typescriptreact = true,
        go = true,
        rust = true,
      }

      if prefer_keyword[ft] then
        for _, item in ipairs(items) do
          if item.kind == kind.Keyword then
            item.score_offset = (item.score_offset or 0) + 4
          end
        end
      end

      return items
    end,
    providers = {
      lsp = {
        score_offset = 5,
        -- Show buffer words alongside active LSP results.
        fallbacks = {},
        transform_items = function(_, items)
          local kind = require("blink.cmp.types").CompletionItemKind
          for _, item in ipairs(items) do
            local is_call = item.kind == kind.Function or item.kind == kind.Method
            local label = type(item.label) == "string" and item.label:match("[_%a][_%w]*") or nil
            if is_call and label ~= nil then
              local call_snippet = label .. "($0)"
              item.insertTextFormat = vim.lsp.protocol.InsertTextFormat.Snippet
              item.insertText = call_snippet

              if type(item.textEdit) == "table" and item.textEdit.newText ~= nil then
                item.textEdit.newText = call_snippet
              end
            end
          end

          return items
        end,
      },
      snippets = {

        -- Keep snippets available, but don't let them dominate short prefixes like `co`.
        min_keyword_length = 3,
        score_offset = -6,
      },
      buffer = {
        score_offset = -4,
      },
      dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
    },
  },
  snippets = {
    preset = "luasnip",
    score_offset = -8,
  },
  completion = {
    list = {
      selection = {
        preselect = function(_ctx)
          return not require("blink.cmp").snippet_active({ direction = 1 })
        end,
        auto_insert = false,
      },
    },
    accept = {
      auto_brackets = {
        enabled = false,
      },
    },
    ghost_text = {
      enabled = false,
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 100,
      treesitter_highlighting = true,
      window = {
        border = "rounded",
        max_width = 44,
        max_height = 12,
      },
    },
    menu = {
      enabled = true,
      min_width = 8,
      max_height = 8,
      border = "rounded",
      winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
      auto_show = true,
      scrollbar = false,
      draw = {
        treesitter = { "lsp" },
        columns = {
          { "kind_icon" },
          { "label", "label_description", gap = 1 },
          { "source_name" },
        },
        components = {
          kind_icon = {
            ellipsis = false,
            ---@param ctx blink.cmp.DrawItemContext
            ---@return string
            text = function(ctx)
              ---@type config.IconsModule
              local icons = require("config.icons")
              ---@type table<string, string>
              local kind_icons = icons.kinds
              ---@type string|nil
              local icon = kind_icons[ctx.kind]
              if icon == nil then
                icon = ctx.kind_icon
              end
              return icon .. ctx.icon_gap
            end,
          },
          label = {
            width = { fill = true, max = 42 },
          },
          label_description = {
            width = { max = 18 },
          },
          source_name = {
            width = { max = 6 },
          },
        },
      },
      ---@return string[]
      direction_priority = function()
        ---@type blink.cmp.Context|nil
        local ctx = require("blink.cmp").get_context()
        ---@type blink.cmp.CompletionItem|nil
        local item = require("blink.cmp").get_selected_item()
        if ctx == nil or item == nil then
          return { "s", "n" }
        end

        ---@type string
        local item_text = item.textEdit ~= nil and item.textEdit.newText or item.insertText or item.label
        ---@type boolean
        local is_multi_line = item_text:find("\n") ~= nil

        if is_multi_line or vim.g.blink_cmp_upwards_ctx_id == ctx.id then
          vim.g.blink_cmp_upwards_ctx_id = ctx.id
          return { "n", "s" }
        end
        return { "s", "n" }
      end,
    },
  },

  fuzzy = {
    sorts = {
      "exact",
      "score",
      "sort_text",
    },
  },
}

function M.setup()
  require("blink.cmp").setup(opts)
end

return M
