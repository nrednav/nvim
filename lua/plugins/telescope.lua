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

		local function apply_theme(command, opts)
			local themes = require("telescope.themes")
			return function()
				command(themes.get_ivy(opts))
			end
		end

		vim.keymap.set("n", "<leader>ff", apply_theme(builtin.find_files))
		vim.keymap.set("n", "<leader>fh", apply_theme(builtin.help_tags))
		vim.keymap.set(
			"n",
			"<leader>fn",
			apply_theme(builtin.find_files, {
				cwd = "~/docs/blue",
				prompt_title = "<- NOTES ->",
			})
		)
		vim.keymap.set("n", "<leader>lg", apply_theme(require("plugins.custom.telescope.multi-ripgrep")))
		vim.keymap.set("n", "<leader>fb", apply_theme(builtin.current_buffer_fuzzy_find))
		vim.keymap.set(
			"n",
			"<leader>fp",
			apply_theme(builtin.find_files, {
				cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"),
			})
		)
		vim.keymap.set("n", "<leader>fg", apply_theme(builtin.git_files))
		vim.keymap.set(
			"n",
			"<leader>vc",
			apply_theme(builtin.find_files, {
				path_display = { "shorten" },
				cwd = "~/.config/nvim",
				prompt_title = "<- NVIMRC ->",
			})
		)
	end,
	config = function()
		local data = assert(vim.fn.stdpath("data"))

		require("telescope").setup({
			extensions = {
				wrap_results = true,
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
				history = {
					path = vim.fs.joinpath(data, "telescope_history.sqlite3"),
					limit = 100,
				},
			},
		})

		require("telescope").load_extension("fzf")
		require("telescope").load_extension("smart_history")
	end,
}
