# v470n's Neovim Configuration

<div align="center">

![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)
![GitHub last commit](https://img.shields.io/github/last-commit/valonmulolli/nvim?style=for-the-badge)
![License](https://img.shields.io/github/license/valonmulolli/nvim?style=for-the-badge)

A minimalist yet powerful Neovim configuration focused on providing a blazing-fast development environment with LSP integration, intelligent code completion, and extensive language support.

[Features](#features) •
[Prerequisites](#prerequisites) •
[Installation](#installation) •
[Keybindings](#key-bindings) •
[Configuration](#configuration) •
[Themes](#themes) •
[Troubleshooting](#troubleshooting)

</div>

## Features

### Core Features

- Clean, minimal UI with full transparency support
- Blazing fast startup with lazy loading
- Smart plugin management with lazy.nvim
- Well-organized modular configuration
- Extensive filetype support with custom settings
- Format on save with LSP and null-ls
- Smart workspace detection and project management
- Enhanced terminal integration with toggleterm
- Consistent coding style with EditorConfig support
- Advanced window and buffer management
- Custom commands and keymaps for improved workflow
- Automatic session management

### Development Features

- Full LSP integration with Mason for easy server management
- Intelligent code completion with nvim-cmp and LuaSnip
- GitHub Copilot integration
- Advanced syntax highlighting with Treesitter
- Git integration (gitsigns, diffview, git-conflict)
- DAP (Debug Adapter Protocol) support for multiple languages
- Telescope fuzzy finder with smart workspace search
- Auto pairs and smart indentation
- Todo comments with workspace searching
- Project management with sessions
- Code runner for multiple languages
- Neorg for note-taking and organization
- Hex editor support
- Built-in terminal with smart window management

### UI Elements

- Modern minimalist look with optional transparency
- Extensive theme collection:
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
- Smart statusline with context awareness
- Which-key for keybinding discoverability
- Snacks - minimal notifications
- Rainbow delimiters and indent guides
- Satellite scrollbar
- Barbecue context bar
- Color preview for CSS/SCSS/LESS

### Language Support

Comprehensive support for:

- Go
- Rust
- Python
- Lua
- JavaScript/TypeScript
- C/C++
- HTML/CSS
- Markdown
- And many more...

## Prerequisites

### Required

- Neovim >= 0.9.0
- Git
- A [Nerd Font](https://www.nerdfonts.com/) (JetBrainsMono Nerd Font recommended)
- Node.js >= 16.x
- ripgrep (for telescope search)
- make, gcc (for treesitter)

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

1. Open Neovim
2. Run `:Mason`
3. Press `i` to install desired servers

## Key Bindings

### General Operations

| Keybind      | Description               |
| ------------ | ------------------------- |
| `<Space>`    | Leader key                |
| `<C-s>`      | Save file                 |
| `<C-d>`      | Duplicate line            |
| `<C-z>`      | Undo (insert mode)        |
| `<leader>q`  | Quit file                 |
| `<leader>wq` | Save and quit             |
| `<leader>nf` | New file                  |
| `<leader>nt` | New tab                   |
| `<ESC>`      | Clear search highlighting |
| `Y`          | Yank until end of line    |

### Navigation

| Keybind         | Description                  |
| --------------- | ---------------------------- |
| `<Tab>/<S-Tab>` | Next/previous buffer         |
| `<C-o>`         | Jump back in history (zz)    |
| `<C-i>`         | Jump forward in history (zz) |
| `n/N`           | Next/prev search result (zz) |
| `*`             | Search word under cursor     |
| `<c-w>d`        | Delete buffer                |
| `[d/]d`         | Previous/next diagnostic     |

### Window Management

| Keybind         | Description             |
| --------------- | ----------------------- |
| `<leader>pv`    | Split vertically        |
| `<leader>ph`    | Split horizontally      |
| `<leader>pe`    | Equal split size        |
| `<leader>px`    | Close split             |
| `<leader>po`    | Keep only current split |
| `<C-S-H/J/K/L>` | Resize splits           |

### LSP Features

| Keybind      | Description           |
| ------------ | --------------------- |
| `gD`         | Go to declaration     |
| `gd`         | Go to definition      |
| `gr`         | Go to references      |
| `gi`         | Go to implementation  |
| `gy`         | Go to type definition |
| `K`          | Show hover info       |
| `gK`         | Show signature help   |
| `<C-k>`      | Signature help        |
| `<leader>cr` | Rename symbol         |
| `<leader>ca` | Code action           |
| `<leader>cc` | Run codelens          |
| `<leader>cC` | Refresh codelens      |
| `<leader>cf` | Format document       |
| `<leader>cF` | Toggle format on save |
| `<leader>cl` | Open LSP info         |

### Search & Telescope

| Keybind      | Description           |
| ------------ | --------------------- |
| `<leader>fg` | Live grep             |
| `<leader>fB` | Search in buffer      |
| `<leader>fd` | Document diagnostics  |
| `<leader>fD` | Workspace diagnostics |
| `<leader>fH` | Help pages            |
| `<leader>fj` | Jump list             |
| `<leader>fm` | Man pages             |
| `<leader>fo` | Vim options           |
| `<leader>fr` | Recent files          |
| `<leader>fR` | Resume last picker    |
| `<leader>fs` | Find LSP symbols      |
| `<leader>fS` | Workspace symbols     |
| `<leader>fv` | Neovim config files   |

### Git & Find Operations

| Keybind      | Description        |
| ------------ | ------------------ |
| `<leader>gs` | Stage hunk         |
| `<leader>gr` | Reset hunk         |
| `[h/]h`      | Previous/next hunk |
| `<leader>gc` | Git commits        |
| `<leader>gb` | Git branches       |
| `<leader>gf` | Git files          |
| `<leader>,`  | Switch buffer      |
| `<leader>/`  | Live grep          |
| `<leader>f.` | Find dotfiles      |
| `<leader>fb` | Find buffers       |
| `<leader>fc` | Find colorscheme   |
| `<leader>ff` | Find files         |
| `<leader>fg` | Find git files     |
| `<leader>fh` | Find highlights    |
| `<leader>fk` | Find keymaps       |

### Terminal

| Keybind      | Description              |
| ------------ | ------------------------ |
| `<C-t>`      | Toggle floating terminal |
| `<leader>t`  | Open split terminal      |
| `<Esc><Esc>` | Exit terminal mode       |

### Session Management

| Keybind      | Description              |
| ------------ | ------------------------ |
| `<leader>ss` | Save session             |
| `<leader>sl` | List available sessions  |
| `<leader>sd` | Delete session           |
| `<leader>sr` | Restore session          |
| `<leader>sa` | Toggle autosave session  |
| `<leader>sD` | Disable autosave session |
| `<leader>sp` | Purge orphaned sessions  |

### Code Operations

| Keybind      | Description        |
| ------------ | ------------------ |
| `<leader>r`  | Run file           |
| `<leader>rq` | Close runner       |
| `<leader>rt` | Run in new tab     |
| `<leader>rp` | Run project        |
| `<A-j>`      | Move line down     |
| `<A-k>`      | Move line up       |
| `<A-Up>`     | Move line up       |
| `<A-Down>`   | Move line down     |
| `<`          | Unindent selection |
| `>`          | Indent selection   |

### Debug Operations (DAP)

| Keybind      | Description        |
| ------------ | ------------------ |
| `<F5>`       | Continue           |
| `<leader>dc` | Continue           |
| `<leader>dd` | DAP commands       |
| `<leader>dv` | Variables          |
| `<leader>df` | Test class (Java)  |
| `<leader>dn` | Test method (Java) |

### Window & Session Management

| Keybind      | Description        |
| ------------ | ------------------ |
| `<C-t>`      | Toggle terminal    |
| `<leader>t`  | Open terminal      |
| `<Esc><Esc>` | Exit terminal mode |
| `<leader>ss` | Save session       |
| `<leader>sl` | List sessions      |
| `<leader>sr` | Restore session    |
| `<leader>sd` | Delete session     |

### Plugins & Package Management

| Keybind      | Description         |
| ------------ | ------------------- |
| `<leader>pb` | Build plugins       |
| `<leader>pc` | Clean plugins       |
| `<leader>ph` | Health check        |
| `<leader>pl` | Show plugins (Lazy) |
| `<leader>pp` | Profile plugins     |
| `<leader>pm` | Show Mason          |
| `<leader>fp` | Show projects       |

### Comments & IDE Features

| Keybind     | Description             |
| ----------- | ----------------------- |
| `<C-_>`     | Toggle line comment     |
| `<C-/>`     | Toggle line comment     |
| `<A-A>`     | Toggle block comment    |
| `<leader>h` | Search and replace word |
| `<C-e>`     | Accept Copilot          |
| `<M-[>`     | Previous suggestion     |
| `<M-]>`     | Next suggestion         |
| `<C-]>`     | Dismiss suggestion      |

## Project Structure

```
.
├── init.lua                 # Entry point
├── lazy-lock.json          # Plugin version lock file
├── LICENSE                 # License file
├── README.md              # Documentation
├── after/                 # Post-load configurations
│   ├── ftplugin/         # Filetype-specific settings
│   ├── plugin/           # Plugin-specific settings
│   └── queries/          # Custom tree-sitter queries
├── lua/                   # Main configuration directory
│   ├── config/           # Core configuration modules
│   │   ├── autocmds.lua  # Autocommands
│   │   ├── colors.lua    # Color and theme settings
│   │   ├── commands.lua  # Custom commands
│   │   ├── filetypes.lua # Filetype associations
│   │   ├── icons.lua     # Icon definitions
│   │   ├── keymaps.lua   # Key mappings
│   │   ├── lazy.lua      # Plugin manager setup
│   │   ├── options.lua   # Neovim options
│   │   ├── terminal.lua  # Terminal settings
│   │   └── util.lua      # Utility functions
│   ├── lualine/          # Statusline configurations
│   │   ├── components/   # Custom statusline components
│   │   ├── extensions/   # Statusline extensions
│   │   └── themes/       # Statusline themes
│   ├── plugins/          # Plugin configurations
│   │   ├── colors/       # Colorscheme configurations
│   │   ├── dap/         # Debug adapter configurations
│   │   ├── lsp/         # LSP configurations
│   │   └── *.lua        # Individual plugin setups
│   └── telescope/        # Telescope extensions
│       └── _extensions/  # Custom telescope extensions
```

## Configuration

### Plugin Management

The configuration uses [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management.

1. **Core Plugin Features**:

   - Lazy loading for improved startup time
   - Automatic plugin installation and updates
   - Plugin health checking and profiling
   - Lockfile for reproducible plugin versions

2. **Plugin Commands**:

   - `<leader>pb` - Build plugins
   - `<leader>pc` - Clean plugins
   - `<leader>ph` - Health check plugins
   - `<leader>pl` - Show plugins
   - `<leader>pp` - Profile plugins
   - `<leader>ps` - Sync plugins
   - `<leader>pu` - Update plugins

3. **Adding New Plugins**:

   Add new plugins in `lua/plugins/`:

   ```lua
   return {
     "username/plugin-name",
     event = "VeryLazy",  -- Optional: lazy-load on event
     config = function()
       require("plugin-name").setup({
         -- options
       })
     end
   }
   ```

4. **Key Plugin Categories**:

   - LSP and Completion:

     - nvim-lspconfig - Language server configuration
     - mason.nvim - Package manager for LSP servers
     - nvim-cmp - Completion engine
     - none-ls.nvim - Additional formatting and diagnostics

   - Editor Features:

     - nvim-treesitter - Better syntax highlighting
     - telescope.nvim - Fuzzy finder
     - gitsigns.nvim - Git integration
     - toggleterm.nvim - Terminal integration

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
     - `prettier` - JavaScript/TypeScript/Web
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
