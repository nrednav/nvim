# Neovim Configuration

## Prerequisites

This configuration targets **Neovim Nightly (v0.12.0-dev)**. Stability on stable
releases (v0.10.x) is not guaranteed.

### External Dependencies

The following binaries must be present in the system `$PATH`:

* **ripgrep** (`rg`): Required for Telescope grep functions.
* **Python 3**: Required for backend support.
* *macOS*: Expects `/opt/homebrew/bin/python3.11`
* *Linux/WSL*: Expects `/usr/bin/python3`
* **C Compiler** (`gcc` or `clang`) & **Make**: Required to build
  `telescope-fzf-native`.
* **SQLite3**: Required for `telescope-smart-history`.
* **Nerd Font**: Required for UI icons.

## Installation

1. **Backup existing configuration:**

```bash
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
```

2. **Clone repository:**

```bash
git clone [REPO_URL] ~/.config/nvim
```

3. **Bootstrap:**
Launch Neovim. The plugin manager (`lazy.nvim`) should automatically bootstrap
and install all dependencies.

```bash
nvim
```

## Architecture

* **`lua/core/`**: Vanilla Neovim settings, autocommands, and global keymaps.
* **`lua/plugins/`**: Plugin specifications managed by `lazy.nvim`.
* **`lua/plugins/custom/`**: Decoupled logic modules (e.g., specific Telescope
  handlers, auto-formatting logic).

## Mappings

**Leader Key:** `,` (Comma)

### Essential Overrides

| Key | Function |
| --- | --- |
| `;` | Enter Command Mode (`:`) |
| `<C-Left>` / `<C-Right>` | Cycle Tabs |
| `<C-d>` / `<C-u>` | Scroll half-page and center cursor |

### Fuzzy Finding (Telescope)

| Key | Action | Context |
| --- | --- | --- |
| `<leader>ff` | Find Files | Current working directory |
| `<leader>fg` | Find Git Files | Respects `.gitignore` |
| `<leader>fb` | Find in Buffer | Fuzzy search current buffer |
| `<leader>fh` | Help Tags | Neovim documentation |
| `<leader>vc` | Edit Config | Search `~/.config/nvim` |
| `<leader>lg` | Multi-Ripgrep | Grep with file-type filtering |
| `<leader>u` | Undo Tree | Visual undo history |

## Plugin Manifest

Core plugins managed via `lazy-lock.json`:

* **Package Management:** `lazy.nvim`, `mason.nvim`
* **LSP & Formatting:** `nvim-lspconfig`, `conform.nvim`
* **Completion:** `blink.cmp` (replacing `nvim-cmp`)
* **Debugging:** `nvim-dap`, `nvim-dap-ui`
* **Fuzzy Finding:** `telescope.nvim` (with `fzf-native`, `smart-history`)
* **File Management:** `oil.nvim`
* **UI:** `lualine.nvim`, `gitsigns.nvim`, `everforest` (Theme)
