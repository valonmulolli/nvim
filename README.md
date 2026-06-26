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
  A standalone Neovim configuration built with <code>vim.pack</code>, focused on modern development workflows and productivity.
</p>

## Structure

```
~/.config/nvim/
  init.lua                  # Entry point
  lua/
    config/
      autocmds.lua          # Auto commands
      icons.lua             # Custom icons
      keymaps.lua           # Key bindings
      pack.lua              # vim.pack bootstrap
      pack/                 # Pack registry and runtime helpers
      options.lua           # Editor options
      paths.lua             # Portable path resolution
      util.lua              # Utility functions
    plugins/
      lsp/                  # LSP configs, keymaps, diagnostics, server modules
        servers/            # Per-server LSP settings
      blink.lua             # Completion engine
      retroline.lua         # Native statusline
      snacks.lua            # Dashboard and pickers
      treesitter.lua        # Syntax highlighting
      lspconfig.lua         # LSP bootstrap and safe server enable
      ...                   # Additional plugins
    snippets/               # Custom snippets
  after/
    ftplugin/               # Per-filetype settings
  README.md
```

## Key Bindings

Leader key: `<Space>`

### Core

| Key         | Mode | Description                          |
| ----------- | ---- | ------------------------------------ |
| `<C-s>`     | n, i | Format and save                      |
| `<C-z>`     | i    | Undo                                 |
| `<Esc>`     | n    | Clear search highlight               |
| `<Leader>q` | n    | Quit window                          |
| `<Leader>h` | n    | Search and replace word under cursor |
| `<Leader>/` | n, v | Toggle comment                       |

### Navigation

| Key     | Mode | Description                        |
| ------- | ---- | ---------------------------------- |
| `<C-d>` | n    | Half-page down (centered)          |
| `<C-u>` | n    | Half-page up (centered)            |
| `<C-o>` | n    | Jump back (centered)               |
| `<C-i>` | n    | Jump forward (centered)            |
| `n`     | n    | Next search result (centered)      |
| `N`     | n    | Previous search result (centered)  |
| `*`     | n    | Search word under cursor (no jump) |
| `*`     | v    | Search visual selection            |

### Editing

| Key                  | Mode | Description                   |
| -------------------- | ---- | ----------------------------- |
| `<A-j>` / `<A-Down>` | v    | Move lines down               |
| `<A-k>` / `<A-Up>`   | v    | Move lines up                 |
| `<C-S-d>`            | n    | Duplicate line                |
| `J`                  | n    | Join lines (cursor stays)     |
| `Y`                  | n    | Yank to end of line           |
| `<Leader>p`          | x    | Paste without yanking         |
| `<`                  | v    | Indent left (stay in visual)  |
| `>`                  | v    | Indent right (stay in visual) |

### Windows and Buffers

| Key          | Mode | Description           |
| ------------ | ---- | --------------------- |
| `<Leader>vv` | n    | Split vertical        |
| `<Leader>vh` | n    | Split horizontal      |
| `<Leader>ve` | n    | Equalize splits       |
| `<Leader>vx` | n    | Close split           |
| `<Leader>vo` | n    | Close other splits    |
| `<Leader>vq` | n    | Save and quit window  |
| `<C-w>d`     | n    | Delete current buffer |
| `<Leader>nt` | n    | New tab               |
| `<Leader>nf` | n    | New file              |

### Bufferline

| Key          | Mode | Description              |
| ------------ | ---- | ------------------------ |
| `<S-h>`      | n    | Previous buffer          |
| `<S-l>`      | n    | Next buffer              |
| `[b`         | n    | Previous buffer          |
| `]b`         | n    | Next buffer              |
| `[B`         | n    | Move buffer left         |
| `]B`         | n    | Move buffer right        |
| `<Leader>bp` | n    | Toggle pin               |
| `<Leader>bP` | n    | Close non-pinned buffers |
| `<Leader>bo` | n    | Close other buffers      |
| `<Leader>br` | n    | Close buffers to right   |
| `<Leader>bl` | n    | Close buffers to left    |

### Picker and Explorer (Snacks)

| Key          | Mode | Description               |
| ------------ | ---- | ------------------------- |
| `<Leader>ff` | n    | Find files                |
| `<Leader>fg` | n    | Global grep               |
| `<Leader>f/` | n    | Global grep               |
| `<Leader>fr` | n    | Recent files              |
| `<Leader>fb` | n    | Find buffers              |
| `<Leader>fp` | n    | Projects                  |
| `<Leader>e`  | n    | File explorer             |
| `<Leader>.`  | n    | Toggle scratchpad         |
| `<Leader>cn` | n    | Notification history      |
| `<Leader>xx` | n    | Diagnostics picker        |
| `<Leader>xX` | n    | Buffer diagnostics picker |

### Flash (Motion)

| Key  | Mode    | Description       |
| ---- | ------- | ----------------- |
| `zk` | n, x, o | Flash jump        |
| `Zk` | n, x, o | Flash treesitter  |
| `r`  | o       | Flash remote      |
| `R`  | o, x    | Treesitter search |

### LSP and Diagnostics

| Key          | Mode | Description                   |
| ------------ | ---- | ----------------------------- |
| `gd`         | n    | Go to definition              |
| `gD`         | n    | Go to declaration             |
| `gi`         | n    | Go to implementation          |
| `gr`         | n    | Go to references              |
| `gy`         | n    | Go to type definition         |
| `K`          | n    | Hover documentation           |
| `gK`         | n    | Signature help                |
| `<C-y>`      | i    | Signature help                |
| `<C-k>`      | n    | Signature help (Neovim 0.12+) |
| `<Leader>cl` | n    | LSP info                      |
| `<Leader>cr` | n    | Rename symbol                 |
| `<Leader>ca` | n, v | Code action                   |
| `<Leader>cC` | n    | Refresh codelens              |
| `<Leader>cf` | n, v | Format buffer                 |
| `[d`         | n    | Previous diagnostic           |
| `]d`         | n    | Next diagnostic               |
| `[D`         | n    | Previous error                |
| `]D`         | n    | Next error                    |
| `<Leader>xd` | n    | Line diagnostics float        |

### Git (Gitsigns)

| Key          | Mode | Description     |
| ------------ | ---- | --------------- |
| `]h`         | n    | Next hunk       |
| `[h`         | n    | Previous hunk   |
| `<Leader>gs` | n, v | Stage hunk      |
| `<Leader>gr` | n, v | Reset hunk      |
| `<Leader>gS` | n    | Stage buffer    |
| `<Leader>gu` | n    | Undo stage hunk |
| `<Leader>gR` | n    | Reset buffer    |
| `<Leader>gp` | n    | Preview hunk    |
| `<Leader>gb` | n    | Blame line      |
| `<Leader>gd` | n    | Diff this       |

### Sessions

| Key          | Mode | Description     |
| ------------ | ---- | --------------- |
| `<Leader>ss` | n    | Save session    |
| `<Leader>sl` | n    | Restore session |
| `<Leader>sd` | n    | Delete session  |

### TODO Comments

| Key          | Mode | Description              |
| ------------ | ---- | ------------------------ |
| `[t`         | n    | Previous TODO            |
| `]t`         | n    | Next TODO                |
| `<Leader>ft` | n    | TODO telescope           |
| `<Leader>fT` | n    | TODO/FIX/FIXME telescope |
| `<Leader>xt` | n    | TODO quickfix            |
| `<Leader>xT` | n    | TODO/FIX/FIXME quickfix  |

### Debugging (DAP)

| Key          | Mode | Description            |
| ------------ | ---- | ---------------------- |
| `<Leader>db` | n    | Toggle breakpoint      |
| `<Leader>dB` | n    | Conditional breakpoint |
| `<Leader>dc` | n    | Continue               |
| `<Leader>dC` | n    | Run to cursor          |
| `<Leader>di` | n    | Step into              |
| `<Leader>do` | n    | Step over              |
| `<Leader>dO` | n    | Step out               |
| `<Leader>dp` | n    | Pause                  |
| `<Leader>dr` | n    | Toggle REPL            |
| `<Leader>ds` | n    | Session info           |
| `<Leader>dt` | n    | Terminate              |
| `<Leader>du` | n    | Toggle DAP UI          |
| `<Leader>de` | n, v | Eval expression        |

### Terminal

| Key          | Mode | Description        |
| ------------ | ---- | ------------------ |
| `<Leader>tt` | n    | Toggle terminal    |
| `<C-/>`      | n, t | Toggle terminal    |
| `<C-_>`      | n, t | Toggle terminal    |
| `<Esc>`      | t    | Exit terminal mode |

### Database (Dadbod UI)

| Key          | Mode | Description        |
| ------------ | ---- | ------------------ |
| `<Leader>Du` | n    | Toggle DB UI       |
| `<Leader>Db` | n    | DB find buffer     |
| `<Leader>Dr` | n    | DB rename buffer   |
| `<Leader>Dl` | n    | DB last query info |

### Sidekick (AI Assistant)

| Key          | Mode       | Description                |
| ------------ | ---------- | -------------------------- |
| `<C-.>`      | n, i, t, x | Toggle and focus Sidekick  |
| `<Tab>`      | n          | Apply next edit suggestion |
| `<Leader>aa` | n          | Toggle CLI                 |
| `<Leader>as` | n          | Select CLI tool            |
| `<Leader>ad` | n          | Detach CLI session         |
| `<Leader>at` | n, x       | Send current context       |
| `<Leader>af` | n          | Send current file          |
| `<Leader>av` | x          | Send visual selection      |
| `<Leader>ap` | n, x       | Prompt picker              |
| `<Leader>ao` | n          | Toggle OpenCode            |
| `<Leader>ac` | n          | Toggle Claude              |
| `<Leader>an` | n          | Request new suggestions    |
| `<Leader>ax` | n          | Clear suggestions          |

### Multicursor

| Key               | Mode | Description                       |
| ----------------- | ---- | --------------------------------- |
| `<Leader>mn`      | n, x | Add cursor (next match)           |
| `<Leader>ms`      | n, x | Skip cursor (next match)          |
| `<Leader>ma`      | n, x | Add cursor (previous match)       |
| `<Leader>mS`      | n, x | Skip cursor (previous match)      |
| `<C-leftmouse>`   | n    | Add/remove cursor with mouse      |
| `<C-leftdrag>`    | n    | Mouse drag multicursor            |
| `<C-leftrelease>` | n    | Mouse release multicursor         |
| `<C-q>`           | n, x | Toggle cursor                     |
| `<Left>`          | n, x | Previous cursor (layer only)      |
| `<Right>`         | n, x | Next cursor (layer only)          |
| `<Leader>x`       | n, x | Delete cursor (layer only)        |
| `<Esc>`           | n    | Enable/clear cursors (layer only) |

### Zignite (Code Runner)

| Key          | Mode | Description            |
| ------------ | ---- | ---------------------- |
| `<Leader>r`  | n    | Run file               |
| `<Leader>rf` | n    | Run file               |
| `<Leader>rb` | n    | Select build command   |
| `<Leader>rl` | n    | Run live/watch command |
| `<Leader>rt` | n    | Run file in tab        |
| `<Leader>rv` | n    | Run file in vsplit     |
| `<Leader>rh` | n    | Run file in split      |
| `<Leader>rq` | n    | Close runner           |
| `<Leader>rs` | n    | Stop running code      |

### LÖVE

| Key          | Mode | Description |
| ------------ | ---- | ----------- |
| `<Leader>ll` | n    | Run LÖVE    |
| `<Leader>ls` | n    | Stop LÖVE   |

### Markdown Preview

| Key           | Mode | Description            |
| ------------- | ---- | ---------------------- |
| `<Leader>mdn` | n    | Start Markdown preview |
| `<Leader>mds` | n    | Stop Markdown preview  |

### Undotree

| Key          | Mode | Description     |
| ------------ | ---- | --------------- |
| `<Leader>uu` | n    | Toggle Undotree |

### Neocodeium

| Key     | Mode | Description      |
| ------- | ---- | ---------------- |
| `<C-e>` | i    | Accept word      |
| `<C-r>` | i    | Accept line      |
| `<C-x>` | i    | Clear suggestion |

### Snacks Toggles

| Key          | Mode | Description             |
| ------------ | ---- | ----------------------- |
| `<Leader>us` | n    | Toggle spelling         |
| `<Leader>uw` | n    | Toggle wrap             |
| `<Leader>ul` | n    | Toggle line numbers     |
| `<Leader>uL` | n    | Toggle relative numbers |
| `<Leader>ud` | n    | Toggle diagnostics      |
| `<Leader>uc` | n    | Toggle conceal          |
| `<Leader>uT` | n    | Toggle treesitter       |
| `<Leader>ub` | n    | Toggle dark background  |
| `<Leader>uh` | n    | Toggle inlay hints      |
| `<Leader>ug` | n    | Toggle indent guides    |
| `<Leader>uD` | n    | Toggle dim mode         |

### Treesitter Text Objects

| Key  | Mode | Description             |
| ---- | ---- | ----------------------- |
| `af` | o, v | Select outer function   |
| `if` | o, v | Select inner function   |
| `ac` | o, v | Select outer class      |
| `ic` | o, v | Select inner class      |
| `]m` | n    | Next function start     |
| `]M` | n    | Next function end       |
| `]]` | n    | Next class start        |
| `][` | n    | Next class end          |
| `[m` | n    | Previous function start |
| `[M` | n    | Previous function end   |
| `[[` | n    | Previous class start    |
| `[]` | n    | Previous class end      |

### Incremental Selection

| Key   | Mode | Description     |
| ----- | ---- | --------------- |
| `gnn` | n    | Init selection  |
| `grn` | n    | Increment node  |
| `grc` | n    | Increment scope |
| `grm` | n    | Decrement node  |

## Statusline

Powered by [retroline.nvim](https://github.com/valonmulolli/retroline.nvim). Configuration is in `lua/plugins/retroline.lua`.

- Retro animation enabled
- Transparent highlights (bg = NONE)
- No glass style, no lualine
- Segments: mode, path, diagnostics, location

## LSP and Completion

- Server settings are split under `lua/plugins/lsp/servers/*.lua`
- Startup is resilient: missing binaries are skipped instead of breaking all servers
- Diagnostics shown inline and in lists; detailed float on demand with `<Leader>xd`
- Completion uses `blink.cmp` with LSP + buffer sources and filetype-specific tuning
- Keyword items boosted in code-heavy filetypes
- Formatting handled by Conform with `lsp_fallback = true`

## Languages Supported

**Syntax highlighting (Treesitter):**
Astro, Bash, C, CSS, Dockerfile, Go, HTML, JavaScript/JSX, JSON/JSONC, Just, Lua, Markdown, Odin, Python, Regex, Rust, TOML, TypeScript/TSX, Vim, YAML, Zig

**LSP servers:**
C/C++ (clangd), Go (gopls), Java (jdtls), Lua (lua_ls), Odin (ols), Python (pyright), QML (qmlls), Rust (rust-analyzer), Zig (zls), Astro, Bash, CSS/HTML, Emmet, Fortran, Hyprlang, JSON, LaTeX (texlab), Marksman, Prisma, SQL, Tailwind, Templ, Tinymist/Typst, WGSL, YAML

**Code runners (Zignite):**
C, C++, Rust, Go, Zig, Java, Python, JavaScript/TypeScript, Lua, Haskell, Odin, Fortran, Shell

## Plugins

| Plugin                | Purpose                           |
| --------------------- | --------------------------------- |
| blink.cmp             | Completion engine                 |
| snacks.nvim           | Dashboard, picker, notifications  |
| treesitter            | Syntax and text objects           |
| flash.nvim            | Motion and navigation             |
| conform.nvim          | Formatting                        |
| gitsigns.nvim         | Git hunks and inline blame/diff   |
| bufferline.nvim       | Buffer tabs                       |
| which-key.nvim        | Keybinding hints                  |
| nvim-dap              | Debugging                         |
| auto-session          | Session save/restore              |
| todo-comments.nvim    | TODO highlighting and lists       |
| typescript-tools.nvim | TypeScript tooling and LSP bridge |
| sidekick.nvim         | AI assistant                      |
| neocodeium            | AI completions                    |
| zignite.nvim          | Run file and build workflows      |
| retroline.nvim        | Native statusline                 |
| heap.nvim             | Colorscheme                       |

## Installation

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.bak

# Clone this config
git clone https://github.com/valonmulolli/nvim ~/.config/nvim

# (Optional) Create lua/config/local.lua for local overrides
# See lua/config/paths.lua for fallback defaults

# Start Neovim
nvim
```

## First Run

On first launch, `vim.pack` automatically:

1. Installs all remote plugins from GitHub
2. Runs post-install builds (Mason update, Treesitter parsers, Markdown preview deps)
3. Initializes LSP servers via Mason (installs any missing servers on next startup)
4. Applies the heap.nvim colorscheme

Plugins are locked via `nvim-pack-lock.json` for reproducible installs. Run `:PackUpdate` to update all plugins, or `:PackStatus` to check current versions.

## Requirements

- Neovim 0.12+
- Git
- ripgrep (rg)
- Node.js (for LSP servers)
