local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ","

local plugins = {
  -- Colorscheme
  { 'sainnhe/everforest', lazy = false, priority = 1000 },

  -- Editor
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true }
  },
  {'norcalli/nvim-colorizer.lua'},
  {'mbbill/undotree'},
  { 'numToStr/Comment.nvim'},
  { "windwp/nvim-autopairs"},
  {'tpope/vim-surround'},

  -- Search
  {
    'nvim-telescope/telescope.nvim', version = '0.1.1',
    dependencies = { {'nvim-lua/plenary.nvim'} }
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  },
  {'theprimeagen/harpoon'},
  {'Shougo/defx.nvim', lazy = false },

  -- LSP
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {'williamboman/mason.nvim'},           -- Optional
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},         -- Required
      {'hrsh7th/cmp-nvim-lsp'},     -- Required
      {'hrsh7th/cmp-buffer'},       -- Optional
      {'hrsh7th/cmp-path'},         -- Optional
      {'saadparwaiz1/cmp_luasnip'}, -- Optional
      {'hrsh7th/cmp-nvim-lua'},     -- Optional

      -- Snippets
      {'L3MON4D3/LuaSnip'},             -- Required
      {'rafamadriz/friendly-snippets'}, -- Optional
    }
  },

  -- Syntax
  {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
  {'jose-elias-alvarez/null-ls.nvim'},

  -- Performance
  {'dstein64/vim-startuptime'},
}

require('lazy').setup(plugins, {
  defaults = { lazy = true },
  install = { colorscheme = { "everforest" } },
  checker = { enabled = true },
  performance = {
    cache = { enabled = true },
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "rplugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      }
    }
  }
})
