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
		"terraform",
	}

	local parsers_set = {}

	for _, parser_name in ipairs(parsers_to_install) do
		parsers_set[parser_name] = true
	end

	require("nvim-treesitter").install(parsers_to_install):wait()

	local group = vim.api.nvim_create_augroup("custom-treesitter", { clear = true })

	vim.api.nvim_create_autocmd("FileType", {
		group = group,
		callback = function(args)
			local filetype = vim.bo[args.buf].filetype

			if parsers_set[filetype] then
				local ok, parser = pcall(vim.treesitter.get_parser, args.buf)

				if ok and parser then
					vim.treesitter.start(args.buf)
					vim.bo[args.buf].syntax = "on"
				end
			end
		end,
	})
end

return M
