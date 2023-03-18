local o = vim.opt

-- Options
o.background = "dark"
o.termguicolors = true

-- Theme Specific Options
-- [Everforest]
vim.g.everforest_background = "hard"
vim.g.everforest_better_performance = 1

-- Set colorscheme
vim.cmd("colorscheme everforest")
