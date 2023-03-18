local map = vim.keymap.set

-- Netrw Explorer
map("n", "<leader>pv", vim.cmd.Ex)

-- Use semi-colon for quicker saving ';'
map({ "n", "v" }, ";", ":", { noremap = true })

-- Cycle through open tabs with <left> and <right> arrow keys
map("n", "<C-left>", ":tabprevious<cr>", { noremap = true })
map("n", "<C-right>", ":tabnext<cr>", { noremap = true })

-- Better identing
map("v", "<", "<gv")
map("v", ">", ">gv")
