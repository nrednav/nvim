# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic
Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2026-01-08

### Added

* **nvim-bqf plugin**: Enhanced Quickfix window features including previews,
  auto-resizing, and FZF integration.
* **fzf dependency**: Added to support filtering within the Quickfix interface.
* **Quickfix navigation mappings**: Added `]q` and `[q` for item navigation with
  centered cursor positioning.
* **Location list navigation mappings**: Added `]l` and `[l` for window-local
  list navigation.
* **Quickfix history management**: Added `<leader>qn` (newer) and `<leader>qo`
  (older) to navigate the Quickfix stack.
* **Quickfix utility mappings**: Added `<leader>q` to toggle the window,
  `<leader>qx` to clear history, and `<leader>qe` to empty the current list.
* **Quickfix deletion**: Added `dd` mapping within Quickfix buffers to remove
  specific items from the list.

### Removed

* **stylua formatter**: Removal of the `stylua` configuration from the
  `conform.nvim` setup.
* **stylua installer**: Removal of `stylua` from the `mason-tool-installer`
  managed package list.

## [1.0.1] - 2025-12-23

### Removed

- Removed biome and ts_ls LSP configuration

## [1.0.0] - 2025-12-22

### Added

- Debugging system via `nvim-dap`, `nvim-dap-ui`, and `mason-nvim-dap.nvim`.
- Automated `codelldb` adapter configuration for C and C++ debugging.
- `lazydev.nvim` and `luvit-meta` for enhanced Neovim Lua API development.
- C and C++ formatting support via `clang-format` in `conform.nvim`.
- `mason-lspconfig.nvim` for automated LSP server management.
- Protected loading logic (`pcall`) in `init.lua` with error reporting and "Safe
  Mode" fallback.

### Changed

- Replaced `nvim-cmp` completion engine with `blink.cmp`.
- Updated `blink.cmp` configuration to include signature help, ghost text, and
  specialized source providers.
- Refactored Python provider detection in `globals.lua` to dynamically resolve
  paths for macOS, Linux, and WSL.
- Migrated LSP capability generation to `blink.cmp`.
- Modified `telescope` multi-ripgrep configuration to include hidden files and
  exclude `.git` directories.
- Updated `clangd` LSP configuration with detailed completion styles and header
  insertion policies.
- Transitioned LSP server setup to use `mason-lspconfig` handlers.

### Removed

- `nvim-cmp` and associated source plugins (`cmp-buffer`, `cmp-path`,
  `cmp-nvim-lsp`, `cmp_luasnip`).
- `LuaSnip` snippet engine.
- `lspkind.nvim` UI utility.
- `null-ls.nvim` diagnostic and formatting engine.
- Archived configuration files for `netrw`, `defx.nvim`, `vim-fugitive`, and
  `vim-astro`.
