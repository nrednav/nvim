local M = {}

M.setup = function()
	local group = vim.api.nvim_create_augroup("custom-treesitter", { clear = true })

	require("nvim-treesitter").setup({
		ensure_install = {
			"core",
			"stable",
			"elixir",
		},
	})

	local syntax_on = {
		elixir = true,
	}

	vim.api.nvim_create_autocmd("FileType", {
		group = group,
		callback = function(args)
			local buffer_number = args.buf
			local ok, parser = pcall(vim.treesitter.get_parser, buffer_number)

			if not ok or not parser then
				return
			end

			pcall(vim.treesitter.start)

			local filetype = vim.bo[buffer_number].filetype

			if syntax_on[filetype] then
				vim.bo[buffer_number].syntax = "on"
			end
		end,
	})
end

return M
