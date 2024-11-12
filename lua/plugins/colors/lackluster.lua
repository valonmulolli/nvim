-- Theme/Colorscheme (uncomment section for whichever theme you prefer or use your own)
-- luckluster Theme (Custom Palette)
return {
  -- https://github.com/slugbyte/lackluster.nvim
  'slugbyte/lackluster.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true,
  },
  config = function()
    require('lackluster').setup({
      tweak_color = {
        lack = "default",
        luster = "#59fcff",
        orange = "default",
        yellow = "default",
        green = "#06D001",
        blue = "default",
        red = "#FF204E",

      },
    --   tweak_ui = {
    --     disable_undercurl = false, -- set to true if you want underline instead of undercurl
    --     enable_end_of_buffer = false, -- set to true to show the end_of_buffer ~ symbols in the gutter
    -- },
      tweak_syntax = {
        string = "#DCFFB7",
        string_escape = "#06D001",
        comment = "#8DECB4",
        builtin = "#31ffb6",
        type = "#98E4FF",
        keyword = "#FCFAEE",
        keyword_return = "#FF204E",
        keyword_exception = "#40A2E3",
      },
      tweak_background = {
        normal = "none",
        telescope = 'none',
        menu = 'none',
        popup = "none",
      },
    })
  end,
}
