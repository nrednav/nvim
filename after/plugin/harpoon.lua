local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local map = vim.keymap.set

map("n", "<leader>a", mark.add_file)
map("n", "<C-e>", ui.toggle_quick_menu)

for i = 1, 4 do
  map("n", string.format("<leader>%s", i), function() ui.nav_file(i) end)
end
