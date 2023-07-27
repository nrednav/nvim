return {
  "sainnhe/everforest",
  lazy = false,
  priority = 1000,
  config = function()
    vim.opt.background = "dark"
    vim.opt.termguicolors = true

    vim.g.everforest_background = "hard"
    vim.g.everforest_better_performance = 1

    vim.cmd("colorscheme everforest")
  end
}

