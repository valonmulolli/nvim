<div align="center">

# Neovim Configuration

![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)
![GitHub last commit](https://img.shields.io/github/last-commit/valonmulolli/nvim?style=for-the-badge)
![License](https://img.shields.io/github/license/valonmulolli/nvim?style=for-the-badge)

<img src="neovim.jpg" alt="Neovim Screenshot" width="600"/>

A modular, minimalist Neovim configuration with:

- LSP, DAP, Treesitter, and session management
- Custom lualine theme (lackluster), snacks.nvim, and multiple colorschemes
- Extensive language support (Rust, Go, Python, Lua, JS/TS, etc.)
- Code runner, Love2D integration, and more

---

[Prerequisites](#prerequisites) • [Quick Start](#quick-start) • [Features](#features) • [Key Bindings](#key-bindings) • [Configuration](#configuration) • [Themes](#themes)

</div>

## Prerequisites

### Required

- Neovim >= 0.9.0
- Git
- Nerd Font (for icons)
- Node.js >= 16.x
- ripgrep (for Telescope search)

### Optional (Recommended for full language support)

- cargo (Rust)
- go (Go)
- python3 & pip (Python)
- fd (faster file finding)

## Quick Start

1. **Install prerequisites** (see above)
2. **Backup existing config** (optional):

   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   ```

3. **Clone and launch**:

   ```bash
   git clone https://github.com/valonmulolli/nvim ~/.config/nvim
   nvim  # Plugins install automatically on first launch
   ```

## Features

- **Performance**: Lazy loading, minimal UI, fast startup
- **LSP**: Mason-managed, custom handlers, per-language configs
- **DAP**: nvim-dap, nvim-dap-ui
- **Completion**: nvim-cmp, luasnip, copilot.nvim
- **UI**: Custom lualine theme (lackluster), snacks.nvim, multiple colorschemes
- **Git**: gitsigns.nvim, diffview.nvim, neogit
- **Navigation**: telescope.nvim, hop.nvim, project.nvim
- **Sessions**: session.nvim (autosave, restore, purge)
- **Formatting**: null-ls, format on save, per-language formatters
- **Code Runner**: coderunner.nvim (run files/projects)
- **Love2D**: love2d.nvim integration
- **Treesitter**: Syntax highlighting, folding, textobjects
- **Terminal**: toggleterm.nvim, smart window management
- **Other**: markdown preview, undotree, todo-comments, zen-mode, surround, autopairs, and more

## Themes

- Lackluster (default)
- Gruvbox
- Tokyo Night
- VSCode
- Rose Pine
- Kanagawa
- Material
- Ayu
- Rusty

## Key Bindings

All keybindings use the default leader key (space). Below are the most important keybindings, grouped by functionality:

### Navigation

| Key        | Description                        |
| ---------- | ---------------------------------- |
| Tab        | Next buffer                        |
| S-Tab      | Previous buffer                    |
| C-o        | Previous jump position (centered)  |
| C-i        | Next jump position (centered)      |
| n          | Next search result (centered)      |
| N          | Previous search result (centered)  |
| \*         | Search word under cursor (no jump) |
| v\*        | Search visually selected text      |
| <leader>nt | New tab                            |
| <leader>nf | New file                           |

### Editing

| Key               | Description                            |
| ----------------- | -------------------------------------- |
| v + A-j or A-Down | Move line down                         |
| v + A-k or A-Up   | Move line up                           |
| C-d               | Duplicate current line                 |
| Y                 | Yank to end of line                    |
| v + <             | Decrease indent                        |
| v + >             | Increase indent                        |
| <leader>p         | Replace selection with paste (no yank) |
| <leader>h         | Search and replace current word        |
| i + C-z           | Undo in insert mode                    |
| C-s               | Save file                              |

### LSP (Language Server Protocol)

| Key        | Description                | Mode |
| ---------- | -------------------------- | ---- |
| <leader>cl | Open LspInfo               | n    |
| <leader>cC | Refresh & Display Codelens | n    |
| <leader>cr | Rename                     | n    |
| <leader>cF | Toggle format              | n/v  |
| <leader>ca | Code Action                | n/v  |
| <leader>cc | Run Codelens               | n/v  |
| <leader>cf | Format document            | n/v  |
| gD         | Goto declaration           | n    |
| gd         | Goto definition            | n    |
| gi         | Goto implementation        | n    |
| gr         | Goto references            | n    |
| gy         | Show type definitions      | n    |
| K          | Show hover diagnostic      | n    |
| gK         | Signature Help             | n    |
| <C-y>      | Signature Help             | i    |
| [d         | Previous diagnostic        | n\*  |
| ]d         | Next diagnostic            | n\*  |
| <C-k>      | Signature Help             | n\*  |

\*Only available in Neovim 0.11+.

### Code Runner

| Key        | Description         |
| ---------- | ------------------- |
| <leader>r  | Run current file    |
| <leader>rq | Close runner        |
| <leader>rt | Run file in new tab |
| <leader>rp | Run project         |

### Window Management

| Key        | Description           |
| ---------- | --------------------- |
| <C-w>d     | Delete current buffer |
| <leader>wq | Save and quit window  |
| <leader>q  | Quit window           |

### Session Management

| Keybind    | Description    | Mode |
| ---------- | -------------- | ---- |
| <leader>ss | Save session   | n    |
| <leader>sl | List sessions  | n    |
| <leader>sd | Delete session | n    |

## Plugin Highlights

- **Plugin Manager**: lazy.nvim (automatic install, version lock)
- **LSP**: mason.nvim, nvim-lspconfig, custom handlers for gopls, tsserver, etc.
- **DAP**: nvim-dap, nvim-dap-ui
- **Completion**: nvim-cmp, luasnip, copilot.nvim
- **UI**: lualine.nvim (lackluster theme), snacks.nvim, nvim-web-devicons, barbecue.nvim
- **Git**: gitsigns.nvim, diffview.nvim, neogit
- **Navigation**: telescope.nvim, hop.nvim, project.nvim
- **Sessions**: session.nvim
- **Formatting/Linting**: null-ls.nvim, per-language formatters/linters
- **Code Runner**: coderunner.nvim
- **Love2D**: love2d.nvim
- **Other**: markdown preview, undotree, todo-comments, zen-mode, surround, autopairs

## Project Structure

```text
~/.config/nvim/
├── after/                 # Filetype-specific overrides
├── lua/                   # Lua configuration files
│   ├── config/           # Core config (options, keymaps, etc.)
│   ├── plugins/          # Plugin configs (LSP, DAP, UI, etc.)
│   ├── lualine/          # Statusline and themes
│   └── telescope/        # Telescope extensions
├── init.lua              # Entry point
└── lazy-lock.json        # Plugin versions
```

## Advanced Usage

- **LSP**: Install servers with `:Mason`, configure in `lua/plugins/lsp/`
- **DAP**: Debug adapters in `lua/plugins/dap/`, UI in `nvim-dap-ui`
- **Sessions**: session.nvim (autosave, restore, purge)
- **Themes**: Switch with `:colorscheme <name>`
- **Format on Save**: Toggle with `<leader>cF`
- **Copilot**: Authenticate with `:Copilot auth`

## Troubleshooting

- **LSP not working**: Check `:LspInfo`, verify server in `:Mason`
- **Copilot**: Run `:Copilot status`, check auth
- **Performance**: Run `:checkhealth`, update plugins

## Updating

```bash
cd ~/.config/nvim
git pull
nvim --headless "+Lazy! sync" +qa
```

## Contributing

Contributions welcome! Open an issue or PR.

## License

MIT License. See [LICENSE](LICENSE).

## Acknowledgments

- Neovim community
- Plugin authors
- Inspiration from other configs
