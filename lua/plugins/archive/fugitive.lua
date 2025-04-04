return {
	"tpope/vim-fugitive",
	event = "VeryLazy",
	enabled = false,
	init = function()
		vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
	end,
}
