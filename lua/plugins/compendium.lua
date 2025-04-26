return {
	{
		"nrednav/compendium.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		-- dir = "~/dev/projects/nvim-plugins/compendium.nvim",
		config = function()
			require("compendium").setup({
				landing_dir = "~/docs/blue/notes",
				templates_dir = "~/docs/blue/templates",
				insert_datetime_header = true,
				action_keymap = {
					create_note = "<leader>nn",
					find_notes = "<leader>nf",
					create_note_from_template = "<leader>nt",
					create_cwd_note_from_template = "<leader>nT",
				},
			})
		end,
	},
}
