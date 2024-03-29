return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>fp",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { { "biome", "prettierd", "prettier" } },
			javascriptreact = { { "biome", "prettierd", "prettier" } },
			typescript = { { "biome", "prettierd", "prettier" } },
			typescriptreact = { { "biome", "prettierd", "prettier" } },
			markdown = { "prettierd" },
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
	},
	init = function()
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
	end,
}
