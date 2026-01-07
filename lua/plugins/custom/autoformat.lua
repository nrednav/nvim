local setup = function()
	local conform = require("conform")

	conform.setup({
		formatters_by_ft = {
			cpp = { "clang-format" },
			c = { "clang-format" },
		},
		format_on_save = function(bufnr)
			if vim.g.conform_disable_autoformat or vim.b[bufnr].conform_disable_autoformat then
				return
			end
			return {
				timeout_ms = 500,
				lsp_fallback = true,
			}
		end,
	})

	conform.formatters.injected = {
		options = {
			ignore_errors = false,
			lang_to_formatters = {
				sql = { "sleek" },
			},
		},
	}

	vim.api.nvim_create_autocmd("BufWritePre", {
		group = vim.api.nvim_create_augroup("custom-conform", { clear = true }),
		callback = function(args)
			require("conform").format({
				bufnr = args.buf,
				lsp_fallback = true,
				quiet = true,
			})
		end,
	})

	vim.api.nvim_create_user_command("ConformDisableAutoFormat", function(args)
		if args.bang then
			vim.b.conform_disable_autoformat = true
		else
			vim.g.conform_disable_autoformat = true
		end
	end, {
		desc = "Disable autoformat on save",
		bang = true,
	})

	vim.api.nvim_create_user_command("ConformEnableAutoFormat", function()
		vim.b.conform_disable_autoformat = false
		vim.g.conform_disable_autoformat = false
	end, {
		desc = "Enable autoformat on save",
	})
end

setup()

return { setup = setup }
