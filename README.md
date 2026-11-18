<p align="center">
  <h1 align="center">Neovim Configuration</h1>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Neovim-0.12%2B-green?style=flat&logo=neovim" alt="Neovim 0.12+">
  <img src="https://img.shields.io/github/license/valonmulolli/nvim?style=flat" alt="MIT License">
  <img src="https://img.shields.io/github/last-commit/valonmulolli/nvim?style=flat" alt="Last commit">
  <img src="https://img.shields.io/github/repo-size/valonmulolli/nvim?style=flat" alt="Repo size">
</p>

<p align="center">
  A personal Neovim setup built around native <code>vim.pack</code>.
</p>

## Install

Requirements: Neovim 0.12+, Git, and ripgrep. Node.js, Bun, and Rust/Cargo are needed only for language servers and optional tools that use them.

Back up an existing `~/.config/nvim`, then run:

```sh
git clone https://github.com/valonmulolli/nvim ~/.config/nvim
nvim
```

On first launch, Neovim installs plugins, Mason installs configured language tools, and Tree-sitter sets up parsers. Check progress with `:PackStatus` and `:Mason`. Plugins are pinned in `nvim-pack-lock.json`; update them with `:PackUpdate`.

## Features

- LSP with per-server settings and Mason-managed tools
- Blink completion for LSP, buffers, paths, and snippets; Copilot inline suggestions appear while typing
- Formatting with Conform
- Tree-sitter highlighting and text objects
- Snacks pickers, explorer, and notifications
- Retroline statusline and Zignite code runner

## Useful Keys

Leader key: `<Space>`.

- `<C-s>`: Save
- `<C-e>`: Accept the next word of a Copilot suggestion
- `<C-r>`: Accept the Copilot suggestion line
- `<C-x>`: Dismiss the Copilot suggestion
- `<Leader>ff`: Find files
- `<Leader>fg`: Search project
- `<Leader>fb`: Find buffers
- `<Leader>e`: File explorer
- `gd`: Go to definition
- `K`: Hover documentation
- `<Leader>ca`: Code action
- `<Leader>cf`: Format buffer

Use `which-key` to discover the other mappings.

## Config Layout

- `lua/config/`: editor options, keymaps, and startup
- `lua/plugins/`: plugin and LSP setup
- `lua/snippets/`: custom snippets
- `after/ftplugin/`: filetype-specific settings

## License

This configuration is licensed under the [MIT License](LICENSE).
