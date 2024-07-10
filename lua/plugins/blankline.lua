return {
  "lukas-reineke/indent-blankline.nvim",
  dev = true,
  main = "ibl",
  opts = {
      indent = {
          smart_indent_cap = false,
      },
      current_indent = {
          enabled = true,
      },
      scope = {
          enabled = false,
      },
      exclude = {
          filetypes = { "org" },
      },
  },
  config = function()
  end,
}