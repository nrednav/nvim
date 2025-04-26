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

-- Execute line, file
map("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Execute the current line" })
map("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Execute the current file" })

-- Insert DateTime header
local function get_day_with_ordinal(day)
	if day > 3 and day < 21 then
		return day .. "th"
	end

	local last_digit = day % 10

	if last_digit == 1 then
		return day .. "st"
	elseif last_digit == 2 then
		return day .. "nd"
	elseif last_digit == 3 then
		return day .. "rd"
	else
		return day .. "th"
	end
end

local function get_formatted_datetime()
	local now = os.date("*t")
	local year = now.year
	local month = os.date("%B", os.time(now))
	local day = now.day
	local day_with_ordinal = get_day_with_ordinal(day)
	local time_24h = string.format("%02d:%02d", now.hour, now.min)

	return string.format("%d - %s %s, %s", year, month, day_with_ordinal, time_24h)
end

vim.api.nvim_create_user_command("InsertDateTimeHeader", function()
	local datetime_string = get_formatted_datetime()
	vim.api.nvim_buf_set_lines(0, 0, 0, true, { datetime_string, "" })
end, {})

map("n", "<leader>dth", ":InsertDateTimeHeader<CR>", { noremap = true, silent = true })
