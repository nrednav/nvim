return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		branch = "main",
		lazy = false,
		enabled = true,
		config = function()
			require("plugins.custom.treesitter").setup()
		end,
	},
}
