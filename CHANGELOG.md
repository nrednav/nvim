# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic
Versioning](https://semver.org/spec/v2.0.0.html).

## [v1.7.1] - 2026-01-27

### Fixed

- Updated `typescript-tools` to not load for javascript and javascriptreact file
  types

## [1.7.0] - 2026-01-26

### Added

- `Makefile` and `scripts/benchmark.sh` to automate environment setup and
  enforce performance thresholds.
- Git pre-commit hook to block commits if Neovim startup time exceeds 60ms.

### Changed

- Refactored `get_python_path` in `lua/core/globals.lua` to replace synchronous
  I/O (`io.open`) with non-blocking `vim.env` and `vim.uv` checks.
- Configured aggressive lazy-loading for `blink.cmp`, `nvim-dap`,
  `nvim-treesitter`, `nvim-lspconfig`, `tsc.nvim`, and `typescript-tools.nvim`
  using `event`, `keys`, `cmd`, and `ft` triggers.

### Removed

- `harpoon` and `telescope-undo.nvim` plugins.

## [1.6.0] - 2026-01-26

### Added

- `nvim-notify` plugin to handle system notifications, replacing the default
  `vim.notify`.
- `tsc.nvim` plugin for asynchronous, project-wide TypeScript type checking.
- `typescript-tools.nvim` for TypeScript LSP integration, enabling inlay hints
  and JSX tag closing.

## [1.5.0] - 2026-01-25

### Added

- `lua/plugins/luasnip.lua` to configure `L3MON4D3/LuaSnip` with keybindings for
  jump (`<C-j/k>`) and choice cycling (`<C-l>`).
- `lua/snippets/elixir.lua` providing custom snippets for modules, functions,
  and GenServer components.

### Changed

- Configured `blink.cmp` to use the `luasnip` preset and removed explicit
  provider definitions in `lua/plugins/blink.lua`.
- Moved `friendly-snippets` dependency from `blink.cmp` to `LuaSnip`
  configuration.

## [1.4.0] - 2026-01-24

### Added

- Added ftplugins for yaml and json, to set cursorcolumn

## [1.3.0] - 2026-01-14

### Added

- Created `after/ftplugin/cpp.lua` to append include paths to
  `vim.opt_local.path`.
- Added `lua/plugins/conform.lua` to configure `conform.nvim` with
  `clang-format` and `stylua`.
- Added user commands `ConformDisable` and `ConformEnable` to control
  auto-formatting.
- Added `stylua` to the list of configured formatters.
- Added global file ignore patterns to Telescope configuration for build
  artifacts and system files.
- Added exclusion patterns for `vcpkg` and `build` directories in the custom
  multi-ripgrep picker.

### Changed

- Refactored `lua/plugins/lsp.lua` to use the `LspAttach` autocommand for
  keybindings instead of the `on_attach` callback.
- Migrated LSP server setup to use `vim.lsp.config` and `vim.lsp.enable` within
  Mason handlers.
- Moved `clangd` configuration to a manual setup block to ensure specific flags
  are applied.
- Updated `lua_ls` settings to recognize the `vim` global.
- Disabled the document formatting provider for `yamlls`.

### Removed

- Deleted `lua/plugins/custom/autoformat.lua`.
- Removed `ConformDisableAutoFormat` and `ConformEnableAutoFormat` commands.
- Removed `conform.nvim` dependency and setup call from `lua/plugins/lsp.lua`.

## [1.2.0] - 2026-01-09

### Added

* Added some useful mappings and options that I use in another workspace

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
