return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Core Dependencies
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",

			-- UI/UX Enhancements
			{ "j-hui/fidget.nvim", opts = {} },
			{ "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },

			-- Other Tools
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"stevearc/conform.nvim",
			"b0o/SchemaStore.nvim",
		},
		config = function()
			local on_attach = function(client, bufnr)
				local builtin = require("telescope.builtin")
				local opts = { buffer = bufnr, noremap = true, silent = true }

				vim.keymap.set("n", "gd", builtin.lsp_definitions, opts)
				vim.keymap.set("n", "gr", builtin.lsp_references, opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, opts)

				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>wd", builtin.lsp_document_symbols, opts)

				vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
				vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "]g", vim.diagnostic.goto_next, opts)
			end

			local capabilities = require("blink.cmp").get_lsp_capabilities()

			require("mason").setup()

			local servers = {
				bashls = {},
				clangd = {
					cmd = {
						"clangd",
						"--background-index",
						"--clang-tidy",
						"--header-insertion=iwyu",
						"--completion-style=detailed",
						"--function-arg-placeholders",
						"--fallback-style=llvm",
					},
					init_options = {
						usePlaceholders = true,
						completeUnimported = true,
						clangdFileStatus = true,
					},
					capabilities = {
						offsetEncoding = { "utf-16" },
					},
				},
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							workspace = { checkThirdParty = false },
							telemetry = { enable = false },
						},
					},
				},
				yamlls = {
					settings = {
						yaml = {
							schemaStore = {
								enable = false,
								url = "",
							},
							schemas = require("schemastore").yaml.schemas(),
						},
					},
				},
				jsonls = {
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				},
			}

			require("mason-lspconfig").setup({
				ensure_installed = vim.tbl_keys(servers),
				handlers = {
					function(server_name)
						local server_config = servers[server_name] or {}
						-- Merge on_attach and capabilities into every server config
						server_config.on_attach = on_attach
						server_config.capabilities = capabilities

						-- Pass to lspconfig
						require("lspconfig")[server_name].setup(server_config)
					end,
				},
			})

			require("mason-tool-installer").setup({
				ensure_installed = {
					"clangd",
					"clang-format",
					"codelldb",
				},
			})

			require("plugins.custom.autoformat").setup()
			require("lsp_lines").setup()

			vim.diagnostic.config({ virtual_text = true, virtual_lines = false })

			vim.keymap.set("", "<leader>dl", function()
				local config = vim.diagnostic.config() or {}

				if config.virtual_text then
					vim.diagnostic.config({ virtual_text = false, virtual_lines = true })
				else
					vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
				end
			end, { desc = "Toggle lsp_lines" })

			-- vim.lsp.config("expert", {
			-- 	cmd = {
			-- 		"/Users/vandern/dev/sources/expert/apps/expert/_build/prod/rel/plain/bin/start_expert",
			-- 		"--stdio",
			-- 	},
			-- 	root_markers = { "mix.exs", ".git" },
			-- 	filetypes = { "elixir", "eelixir", "heex" },
			-- 	capabilities = capabilities,
			-- 	on_attach = function(client, bufnr)
			-- 		client.server_capabilities.documentFormattingProvider = false
			-- 		on_attach(client, bufnr)
			-- 	end,
			-- })
			--
			-- vim.lsp.enable("expert")
		end,
	},
}
