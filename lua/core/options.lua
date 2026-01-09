local o = vim.opt
local api = vim.api

-- General
o.hidden = true
o.secure = true
o.belloff = "all"
o.showcmd = true
o.switchbuf = "usetab,newtab"

-- Search
o.hlsearch = false
o.incsearch = true
o.ignorecase = true
o.smartcase = true

-- Editor
o.relativenumber = true
o.number = true
o.colorcolumn = "80"
o.textwidth = 80
o.signcolumn = "yes"
o.scrolloff = 8
api.nvim_set_hl(0, 'ColorColumn', { ctermbg = "darkgray" })

-- Editing
o.expandtab = true
o.smartindent = true
o.autoindent = true
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2

-- Splits
o.splitright = true
o.splitbelow = true

-- Performance
o.updatetime = 300
