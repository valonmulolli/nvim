-- nvim-autopairs | autopairs for neovim written by lua
-- https://github.com/windwp/nvim-autopairs

---@type LazySpec
return {
  "windwp/nvim-autopairs",
  event = { "InsertEnter" },
  opts = {
    check_ts = true,
    disable_filetype = { "TelescopePrompt", "vim" },
    fast_wrap = {},
    ts_config = {
      lua = { "string", "source" },
      javascript = { "string", "template_string" },
    },
  },
  config = function(_, opts)
    local npairs = require("nvim-autopairs")
    npairs.setup(opts)

    -- Enable cmp compatibility
    local cmp_ok, cmp = pcall(require, "cmp")
    if cmp_ok then
      local cmp_npairs = require("nvim-autopairs.completion.cmp")
      local handlers = require("nvim-autopairs.completion.handlers")
      -- Complete parens after select function or method item
      cmp.event:on(
        "confirm_done",
        cmp_npairs.on_confirm_done({
          filetypes = {
            sh = false,
            ps1 = false,
            ["*"] = { -- "*" alias to all filetypes
              ["("] = {
                kind = {
                  cmp.lsp.CompletionItemKind.Function,
                  cmp.lsp.CompletionItemKind.Method,
                },
                handler = handlers["*"],
              },
            },
          },
        })
      )
    end

    --- Rules ---

    local Rule = require("nvim-autopairs.rule")
    local conds = require("nvim-autopairs.conds")

    -- Javascript arrow function
    npairs.add_rule(Rule("%(.*%)%s*%=>$", " {}", {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    }):use_regex(true):set_end_pair_length(1))

    -- Add angle bracket pairs to filetypes
    npairs.add_rule(Rule("<", ">", { "cs", "rust" }):with_move(conds.after_regex("<")))

    -- Add pipe pairs to filetypes
    npairs.add_rule(Rule("|", "|", { "go", "rust" }):with_move(conds.after_regex("|")))

    -- Disable single quote pairs in lisp filetypes
    npairs.get_rules("'")[1].not_filetypes = { "scheme", "lisp", "clojure" }
    npairs.get_rules("'")[1]:with_pair(conds.not_after_text("["))
  end,
}
