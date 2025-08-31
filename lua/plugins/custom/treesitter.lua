local M = {}

M.setup = function()
	local parsers_to_install = {
		"json",
		"cpp",
		"elixir",
		"markdown",
		"javascript",
		"typescript",
		"go",
		"lua",
		"vim",
		"vimdoc",
		"heex",
	}

	require("nvim-treesitter").install(parsers_to_install):wait()

	local group = vim.api.nvim_create_augroup("custom-treesitter", { clear = true })

	vim.api.nvim_create_autocmd("FileType", {
		group = group,
		callback = function(args)
			local ok, parser = pcall(vim.treesitter.get_parser, args.buf)
			if ok and parser then
				vim.treesitter.start(args.buf)
			end
		end,
	})
end

return M
