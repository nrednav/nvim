return {
	"kevinhwang91/nvim-bqf",
	ft = "qf", -- Lazy load only when a Quickfix window is opened
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"junegunn/fzf",
	},
	config = function()
		require("bqf").setup({
			auto_enable = true,
			auto_resize_height = true,
			preview = {
				win_height = 12,
				win_vheight = 12,
				delay_syntax = 80,
				border = "rounded",
				show_title = false,
				should_preview_callback = function(bufnr)
					local ret = true
					local filename = vim.api.nvim_buf_get_name(bufnr)
					local fsize = vim.fn.getfsize(filename)
					-- Skip preview for files larger than 100kb to prevent lag
					if fsize > 100 * 1024 then
						ret = false
					end
					return ret
				end,
			},
			-- Custom function map for standard BQF features
			func_map = {
				open = "<CR>",
				openc = "o", -- Open and close QF window
				drop = "O", -- Open, keep QF open
				split = "<C-x>",
				vsplit = "<C-v>",
				stoggleup = "M", -- Toggle sign (mark) for selection
				stoggledown = "m", -- Toggle sign (mark) for selection
				stogglevm = "<Tab>", -- Toggle sign in visual mode
				filter = "zn", -- Create new list from signed items
				filterr = "zN", -- Create new list from NON-signed items
				fzffilter = "zf", -- Enter FZF mode to filter items
			},
		})

		-- "dd" to remove items from the Quickfix list
		-- Native QF lists are read-only; this helper function makes them feel editable.
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "qf",
			callback = function()
				vim.keymap.set("n", "dd", function()
					local curqfidx = vim.fn.line(".")
					local qfall = vim.fn.getqflist()

					-- Return if list is empty
					if #qfall == 0 then
						return
					end

					-- Remove the item at the current line
					table.remove(qfall, curqfidx)

					-- Replace the quickfix list with the modified table
					vim.fn.setqflist(qfall, "r")

					-- Restore cursor position (setqflist resets it)
					vim.fn.cursor(curqfidx, 1)
				end, { buffer = true, desc = "Delete item from Quickfix list" })
			end,
		})
	end,
}
