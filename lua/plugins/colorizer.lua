return {
  'norcalli/nvim-colorizer.lua',
  event = "VeryLazy",
  config = function()
    require('colorizer').setup({
      'css';
      'javascript';
      'lua';
      html = {
        mode = 'foreground';
      }
    })
  end
}
