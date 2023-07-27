return {
  'nvim-lualine/lualine.nvim',
  event = "VeryLazy",
  dependencies = {
    { 'nvim-tree/nvim-web-devicons', lazy = true },
  },
  init = function()
    require("lualine").setup({
      options = { theme = 'everforest' }
    })
  end
}
