local map = vim.keymap.set

-- Netrw Explorer
map("n", "<leader>fe", vim.cmd.Ex)

-- Use semi-colon for quicker saving ';'
map({ "n", "v" }, ";", ":", { noremap = true })

-- Cycle through open tabs with <left> and <right> arrow keys
map("n", "<C-left>", ":tabprevious<cr>", { noremap = true })
map("n", "<C-right>", ":tabnext<cr>", { noremap = true })

-- Better identing
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move highlighted blocks
map("v", "J", ":m '>+1<cr>gv=gv")
map("v", "K", ":m '<-2<cr>gv=gv")

-- Keep cursor centered while half-page jumping
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Keep cursor centered while navigating through search terms
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Change to directory of currently open file
map("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>", { noremap = true })
