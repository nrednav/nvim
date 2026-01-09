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

-- Quickfix list navigation (Next/Prev Item)
map("n", "]q", "<cmd>cnext<CR>zz", { desc = "Forward qfix list" })
map("n", "[q", "<cmd>cprev<CR>zz", { desc = "Backward qfix list" })

-- Location list navigation (Next/Prev Item)
-- Note: Location lists are like Quickfix lists but local to the window
map("n", "]l", "<cmd>lnext<CR>zz", { desc = "Forward location list" })
map("n", "[l", "<cmd>lprev<CR>zz", { desc = "Backward location list" })

-- Quickfix History Navigation (Newer/Older List)
-- Essential when you accidentally throw away a list with a new Telescope search
map("n", "<leader>qn", "<cmd>cnewer<CR>", { desc = "Go to newer quickfix list" })
map("n", "<leader>qo", "<cmd>colder<CR>", { desc = "Go to older quickfix list" })

-- Clear Quickfix History
-- This destroys the entire stack of lists and closes the window.
map("n", "<leader>qx", function()
  -- 'f' flag tells setqflist to replace the entire stack with a new empty one
  vim.fn.setqflist({}, "f")
  vim.cmd("cclose")
  vim.notify("Quickfix history cleared", vim.log.levels.INFO)
end, { desc = "Clear Quickfix History" })

-- Empty ONLY the current list (History remains)
map("n", "<leader>qe", function()
  vim.fn.setqflist({}, "r")
  vim.notify("Current Quickfix list emptied", vim.log.levels.INFO)
end, { desc = "Empty current Quickfix list" })

-- Toggle Quickfix window
-- This checks if the quickfix window is open; if yes close it, else open it.
map("n", "<leader>q", function()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end
  if qf_exists == true then
    vim.cmd("cclose")
    return
  end
  if not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd("copen")
  end
end, { desc = "Toggle Quickfix" })

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

-- Copy path to current file
vim.api.nvim_set_keymap(
  "n",          -- Mode: Normal Mode
  "<leader>cf", -- The key sequence to map (e.g., '\cf' or ',cf')
  ':let @* = expand("%:p")<CR>',
  -- The command to execute:
  -- @* = system clipboard register
  -- expand("%:p") = current file's full path
  -- <CR> = carriage return (Execute the command)
  {
    noremap = true,
    silent = true,
    desc = "Copy file path"
  }
)
