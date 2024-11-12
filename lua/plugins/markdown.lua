---@type LazyPluginSpec[]
return {
  { -- Nice extra's for markdown documents
    "SidOfc/mkdx",
    ft = "markdown",
  },
  { -- Preview Markdown in the browser
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      -- Ensure the plugin is loaded before executing the install function
      vim.cmd([[packadd markdown-preview.nvim]])  -- This forces LazyVim to load the plugin
      vim.fn["mkdp#util#install"]()  -- Run the plugin's install function
    end,
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_preview_options = {
        hide_yaml_meta = 0,
        Disable_filename = 0,
        ["prefers-color-scheme"] = "dark",
      }
    end,
  },
}
