return {
	"nvim-telescope/telescope.nvim",
	event = "VeryLazy",
	branch = "master",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-telescope/telescope-smart-history.nvim",
		"kkharji/sqlite.lua",
	},
	init = function()
		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>ff", builtin.find_files)
		vim.keymap.set("n", "<leader>fh", builtin.help_tags)
		vim.keymap.set("n", "<leader>lg", require("plugins.custom.telescope.multi-ripgrep"))
		vim.keymap.set("n", "<leader>fb", builtin.buffers)
		vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find)
		vim.keymap.set("n", "<leader>fg", function()
			return builtin.git_files({ cwd = vim.fn.expand("%:h") })
		end)
		vim.keymap.set("n", "<leader>vc", function()
			builtin.find_files({
				path_display = { "shorten" },
				cwd = "~/.config/nvim",
				prompt_title = "<- NVIMRC ->",
			})
		end)
	end,
	config = function()
		require("plugins.custom.telescope")
	end,
}
