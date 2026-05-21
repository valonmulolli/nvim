---@type vim.lsp.Config
return {
  filetypes = { "zig", "zir" },
  root_markers = { "zls.json", "build.zig", "build.zig.zon", ".git" },
  settings = {
    zls = {
      enable_snippets = true,
      -- Keep this off so opening/saving a Zig project does not eagerly create
      -- .zig-cache / zig-out through background build steps.
      enable_build_on_save = false,
    },
  },
}
