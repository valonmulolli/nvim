
<div align="center">

# Neovim Configuration

![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)
![GitHub last commit](https://img.shields.io/github/last-commit/valonmulolli/nvim?style=for-the-badge)
![License](https://img.shields.io/github/license/valonmulolli/nvim?style=for-the-badge)

A minimalist yet powerful Neovim configuration with LSP integration, intelligent code completion, and extensive language support.

[Quick Start](#quick-start) •
[Features](#features) •
[Keybindings](#key-bindings) •
[Configuration](#configuration) •
[Themes](#themes)

</div>

## Quick Start

1. **Install Prerequisites**:

   ```bash
   # Required
   sudo pacman -S neovim git nodejs ripgrep

   # Optional but recommended
   sudo pacman -S lazygit gcc make unzip
   ```

2. **Install Configuration**:

   ```bash
   # Backup existing config
   mv ~/.config/nvim ~/.config/nvim.bak
   mv ~/.local/share/nvim ~/.local/share/nvim.bak

   # Clone and install
   git clone https://github.com/valonmulolli/nvim ~/.config/nvim
   nvim  # First launch will install plugins automatically
   ```

## Key Bindings

### Navigation

| Key          | Description                        |
| ------------ | ---------------------------------- |
| `Tab`        | Next buffer                        |
| `S-Tab`      | Previous buffer                    |
| `C-o`        | Previous jump position (centered)  |
| `C-i`        | Next jump position (centered)      |
| `n`          | Next search result (centered)      |
| `N`          | Previous search result (centered)  |
| `*`          | Search word under cursor (no jump) |
| `v*`         | Search visually selected text      |
| `<leader>nt` | New tab                            |
| `<leader>nf` | New file                           |

### Editing

| Key                   | Description                            |
| --------------------- | -------------------------------------- |
| `v + A-j` or `A-Down` | Move line down                         |
| `v + A-k` or `A-Up`   | Move line up                           |
| `C-d`                 | Duplicate current line                 |
| `Y`                   | Yank to end of line                    |
| `v + <`               | Decrease indent                        |
| `v + >`               | Increase indent                        |
| `<leader>p`           | Replace selection with paste (no yank) |
| `<leader>h`           | Search and replace current word        |
| `i + C-z`             | Undo in insert mode                    |
| `C-s`                 | Save file                              |

### LSP (Language Server Protocol)

| Key          | Description            |
| ------------ | ---------------------- |
| `gD`         | Go to declaration      |
| `gd`         | Go to definition       |
| `gi`         | Go to implementation   |
| `gr`         | Go to references       |
| `gy`         | Show type definition   |
| `K`          | Show hover information |
| `gK`         | Signature help         |
| `[d`         | Previous diagnostic    |
| `]d`         | Next diagnostic        |
| `<leader>cl` | Open LSP info          |
| `<leader>cc` | Run code lens          |
| `<leader>ca` | Code action            |
| `<leader>cr` | Rename symbol          |
| `<leader>cf` | Format document        |
| `<leader>cF` | Toggle auto-formatting |
| `<leader>cC` | Refresh code lens      |

### Code Runner

| Key          | Description         |
| ------------ | ------------------- |
| `<leader>r`  | Run current file    |
| `<leader>rq` | Close runner        |
| `<leader>rt` | Run file in new tab |
| `<leader>rp` | Run project         |

### Window Management

| Key          | Description           |
| ------------ | --------------------- |
| `<C-w>d`     | Delete current buffer |
| `<leader>wq` | Save and quit window  |
| `<leader>q`  | Quit window           |

## Features

### Core Functionality

- **Performance**: Optimized for speed with lazy loading
- **Language Support**: LSP, DAP, and Treesitter integration
- **UI**: Clean interface with multiple themes and statusline
- **Git**: Built-in git integration with gitsigns and diffview
- **Navigation**: Telescope-powered fuzzy finding and file navigation
- **Terminal**: Integrated terminal with smart window management
- **Sessions**: Automatic session management
- **Formatting**: Format on save with LSP and null-ls

### Theme Collection

- Lackluster (default)
- Gruvbox
- Tokyo Night
- VSCode
- Rose Pine
- Kanagawa
- Material
- Ayu
- Moonify
- Rusty

## Prerequisites

### Required

- Neovim >= 0.9.0
- Git
- Nerd Font recommended
- Node.js >= 16.x
- ripgrep (for telescope search)

### Optional

- cargo (for Rust tools)
- go (for Go tools)
- python3 & pip (for Python tools)
- fd (for better file finding)

## Installation

### Automatic Installation

```bash
# Backup existing Neovim configuration
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak

# Clone the repository
git clone https://github.com/valonmulolli/nvim ~/.config/nvim

# Start Neovim
nvim
```

### Post-Installation

The configuration will automatically:

1. Install lazy.nvim (package manager)
2. Install and configure all plugins
3. Set up LSP servers via Mason
4. Install formatters and linters

### Manual LSP Server Installation

If you need to manually install LSP servers:

### Session Management

| Keybind      | Description             | Mode |
| ------------ | ----------------------- | ---- |
| `<leader>ss` | Save session            | n    |
| `<leader>sl` | List sessions           | n    |
| `<leader>sr` | Restore session         | n    |
| `<leader>sd` | Delete session          | n    |
| `<leader>sa` | Toggle autosave         | n    |
| `<leader>sD` | Disable autosave        | n    |
| `<leader>sp` | Purge orphaned sessions | n    |

### Plugin Management

This configuration uses [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management with these features:

- **Lazy Loading**: Plugins load only when needed
- **Automatic Management**: Install/update with a single command
- **Health Checks**: Built-in plugin health verification
- **Reproducible**: Version locking for stability

#### Adding New Plugins

1. Create a new file in `lua/plugins/` (e.g., `lua/plugins/myplugin.lua`)
2. Follow this template:

```lua
return {
  "username/plugin-name",
  event = "VeryLazy",  -- Optional: lazy-load on event
  config = function()
    require("plugin-name").setup({
      -- plugin configuration
    })
  end
}
```

#### Plugin Categories

- **Core**: Essential plugins for basic functionality
- **LSP**: Language Server Protocol support
- **UI**: Interface enhancements and themes
- **Tools**: Development utilities
- **Git**: Version control integration

## Project Structure

```text
~/.config/nvim/
├── after/                 # Filetype-specific overrides
├── lua/                   # Lua configuration files
│   ├── config/           # Core configuration
│   │   ├── autocmds.lua  # Autocommands
│   │   ├── colors.lua    # Color scheme settings
│   │   ├── commands.lua  # Custom commands
│   │   ├── filetypes.lua # Filetype-specific settings
│   │   ├── icons.lua     # Icon definitions
│   │   ├── keymaps.lua   # Key mappings
│   │   ├── lazy.lua      # Plugin manager setup
│   │   ├── options.lua   # Editor options
│   │   ├── terminal.lua  # Terminal configuration
│   │   └── util.lua     # Utility functions
│   │
│   ├── plugins/         # Plugin configurations
│   │   ├── autopairs.lua  # Auto-pairing
│   │   ├── barbecue.lua   # Winbar
│   │   ├── cmp.lua        # Completion
│   │   ├── colors/        # Color schemes
│   │   ├── dap/           # Debug Adapter Protocol
│   │   ├── git/           # Git integration
│   │   ├── lsp/           # Language Server Protocol
│   │   ├── telescope.lua  # Fuzzy finder
│   │   └── ...            # Other plugin configs
│   │
│   ├── lualine/        # Status line config
│   └── telescope/        # Telescope extensions
│
├── init.lua            # Entry point
└── lazy-lock.json       # Plugin versions
```

## Core Features

### LSP Configuration

Language servers are managed via `mason.nvim`. To install a new LSP server:

1. Run `:Mason`
2. Navigate to the desired language server
3. Press `i` to install

Custom LSP settings can be added in `lua/plugins/lsp/settings/`. - gitsigns.nvim - Git integration - toggleterm.nvim - Terminal integration

- UI Enhancements:

  - lualine.nvim - Status line
  - nvim-web-devicons - File icons
  - barbecue.nvim - VS Code-like winbar
  - indent-blankline.nvim - Indentation guides

- Debugging:

  - nvim-dap - Debug adapter protocol
  - nvim-dap-ui - UI for debugging

- Language Specific:
  - rustaceanvim - Enhanced Rust support
  - nvim-jdtls - Java development

### Language Server Protocol (LSP)

The LSP configuration is managed through multiple components:

1. **Mason Package Manager**: Handles the installation of LSP servers

   - Installed via `mason.nvim`
   - Configure in `lua/plugins/mason.lua`
   - Open with `:Mason`

2. **Default LSP Servers**:

   - bashls - Bash
   - clangd - C/C++
   - cssls - CSS
   - dockerls - Docker
   - emmet_ls - HTML/CSS snippets
   - eslint - JavaScript/TypeScript
   - gopls - Go
   - html - HTML
   - jsonls - JSON
   - lua_ls - Lua
   - tsserver - TypeScript/JavaScript
     - Inlay hints for types and parameters
     - Project-aware with `tsconfig.json`/`jsconfig.json`
     - Smart import resolution
   - pyright - Python
   - ruff - Python
   - taplo - TOML
   - yamlls - YAML

3. **Special LSP Configurations**:

   - `jdtls` - Java with advanced features
   - `rust-analyzer` - Enhanced Rust support via RustaceanVim
   - `zk` - Note-taking with markdown

4. **Null-ls Integration**:

   - Provides additional formatting and diagnostics
   - Configured in `lua/plugins/lsp/null-ls.lua`
   - Formatters:
     - `black` - Python
     - `gofmt` - Go
     - `prettier` - JavaScript/TypeScript/Web (with project-specific config support)
     - Auto-formats on save
     - Respects local `.prettierrc` and `package.json` configs
   - `eslint_d` - Fast ESLint integration for JavaScript/TypeScript
     - Auto-fix available via code actions
     - Supports project-specific ESLint configs
     - `stylua` - Lua
     - `shfmt` - Shell scripts
   - Linters:
     - `selene` - Lua
     - `markdownlint` - Markdown
     - `shellcheck` - Shell scripts

5. **Custom LSP Settings**:

   - Located in `lua/plugins/lsp/settings/`
   - Language-specific configurations

   ```lua
   return {
     settings = {
       -- Your language-specific settings
     }
   }
   ```

6. **LSP Features**:
   - Code completion (via nvim-cmp)
   - Diagnostics with inline errors and warnings
   - Code actions and quick fixes
   - Go to definition, references, and implementations
   - Signature help and documentation hover
   - Code formatting on save (configurable per language)
   - Symbol search and workspace management
   - Code lens support for supported languages

### Adding Formatters

Add formatters in `lua/v470n/plugins/lsp/formatting.lua`:

```lua
formatters_by_ft = {
  your_language = { "formatter_name" }
}
```

## Advanced Configuration

### Configuration Options

The configuration includes carefully tuned settings in `lua/config/options.lua`:

1. **Editor Settings**:

   - TextWidth: 80 characters
   - Indentation: 4 spaces (configurable per language)
   - Hybrid line numbers (relative + absolute)
   - Smart case-sensitive search
   - Split behavior: below and right
   - Fast key response (timeoutlen = 250ms)
   - Persistent undo with high limit (10000 levels)

2. **UI Settings**:

   - True color support
   - Custom border styles for floats
   - Minimal UI (no showmode, custom statusline)
   - Mouse support enabled
   - Dynamic cursor style
   - Customizable popup menus
   - Blinking cursor support
   - JetBrainsMono NFM default font

3. **Completion Settings**:

   - Menu with inline documentation
   - No automatic selection
   - Smart trigger characters
   - Performance optimized (25 entries max)
   - Ghost text support
   - Custom borders

4. **File Behavior**:

   - Smart line wrapping
   - Indent preserved on wrap
   - Auto-reload external changes
   - Persistent undo history
   - No swapfile
   - EditorConfig support

5. **Format Options**:

   ```lua
   vim.opt.formatoptions = {
     c = true,  -- Auto-wrap comments
     j = true,  -- Remove comment leader when joining
     l = true,  -- Long lines not broken in insert mode
     n = true,  -- Recognize numbered lists
     o = false, -- No comment leader on o/O
     q = true,  -- Allow formatting with 'gq'
     r = false, -- No comment leader on <Enter>
     t = false, -- No auto-wrap text
   }
   ```

6. **Session Management**:

   - Saves buffers and windows
   - Preserves folds and globals
   - Remembers terminal state
   - Maintains window layout
   - Stores directory info

7. **System Integration**:

   - System clipboard support
   - Fast terminal handling
   - GUI client support
   - Custom wildcard ignore patterns
   - Transparent background support

8. **Special Features**:
   - Diff mode optimizations
   - Treesitter-based folding
   - Smart hybrid line numbers
   - Enhanced completion triggers
   - Custom listchars for whitespace

## Tips and Tricks

### Copilot Usage

1. Run `:Copilot auth` to authenticate
2. Wait for suggestions to appear in ghost text
3. Use keybindings to navigate and accept suggestions

### LSP Features

1. Use `:Mason` to install new language servers
2. Check server status with `:LspInfo`
3. View documentation with `K`
4. Quick fixes available with `<leader>la`

### Format on Save

- Automatic formatting on save with `<C-s>`
- Configure formatters per filetype in formatting.lua
- Toggle format on save with custom commands

## Troubleshooting

### Common Issues

1. **LSP not working:**

   - Check `:LspInfo`
   - Verify server installation in `:Mason`
   - Ensure language server is running

2. **Copilot not showing suggestions:**

   - Run `:Copilot status`
   - Check authentication
   - Verify filetype support

3. **Slow performance:**
   - Run `:checkhealth`
   - Update plugins
   - Check startup time with `nvim --startuptime`

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Thanks to the Neovim community
- Plugin authors and contributors
- Inspiration from various Neovim configurations

---

</div>
