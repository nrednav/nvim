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

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "smart_history")
