local map = vim.keymap.set

-- Use semi-colon for quicker saving ';'
map({ "n", "v" }, ";", ":", { noremap = true })

-- Cycle through open tabs with <left> and <right> arrow keys
map("n", "<C-Left>", ":tabprevious<cr>", { noremap = true })
map("n", "<C-Right>", ":tabnext<cr>", { noremap = true })

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

-- Convert camelCase to snake_case
local function convert_to_snake_case()
	table.unpack = table.unpack or unpack
	local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
	local word = vim.fn.expand("<cword>")
	local word_start = vim.fn.matchstrpos(vim.fn.getline("."), "\\k*\\%" .. (col + 1) .. "c\\k*")[2]

	-- Check if the word is in camelCase
	if word:find("[a-z][A-Z]") then
		-- Convert camelCase to snake_case
		local snake_case_word = word:gsub("([a-z])([A-Z])", "%1_%2"):lower()
		vim.api.nvim_buf_set_text(0, line - 1, word_start, line - 1, word_start + #word, { snake_case_word })
	else
		print("Not a camelCase word")
	end
end

map("n", "<leader>cs", convert_to_snake_case)
