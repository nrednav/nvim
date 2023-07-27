return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    {'L3MON4D3/LuaSnip'},     -- Required
  },
  config = function()
    require('lsp-zero.cmp').extend()

    local cmp = require('cmp')
    local cmp_action = require('lsp-zero.cmp').action()

    cmp.setup({
      mapping = {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-p>'] = cmp_action.luasnip_jump_backward(),
        ['<C-n>'] = cmp_action.luasnip_jump_forward(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
      }
    })
  end
}     -- Required
