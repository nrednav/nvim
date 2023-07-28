return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      dependencies = { "rafamadriz/friendly-snippets" },
    },
    {'hrsh7th/cmp-nvim-lua'},
    {'hrsh7th/cmp-buffer'},
    {'saadparwaiz1/cmp_luasnip'}
  },
  config = function()
    require('lsp-zero.cmp').extend()

    local cmp = require('cmp')
    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      preselect = 'item',
      completion = {
        completeopt = 'menu,menuone,noinsert'
      },
      sources = {
        -- { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "buffer" },
      },
      mapping = {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      }
    })
  end
}
