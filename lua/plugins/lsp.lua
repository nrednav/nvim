return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "folke/lazydev.nvim", ft = "lua" },
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			{ "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },
			"stevearc/conform.nvim",
			"b0o/SchemaStore.nvim",
		},
		config = function()
			local capabilities = nil

			if pcall(require, "cmp_nvim_lsp") then
				capabilities = require("cmp_nvim_lsp").default_capabilities()
			end

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

			require("mason").setup()

			local ensure_installed = {
				"bashls",
				"biome",
				"clangd",
				"jsonls",
				"lua_ls",
				"ts_ls",
				"yamlls",
			}

			require("mason-lspconfig").setup({
				ensure_installed = ensure_installed,
			})

			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							runtime = {
								version = "LuaJIT",
							},
							diagnostics = {
								globals = { "vim" },
							},
							telemetry = {
								enable = false,
							},
						},
					},
					capabilities = {
						textDocument = {
							semanticTokens = false,
						},
					},
				},
				ts_ls = {
					root_dir = require("lspconfig").util.root_pattern("package.json"),
					single_file = false,
					capabilities = {
						textDocument = {
							formatting = false,
							rangeFormatting = false,
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
					capabilities = {
						textDocument = {
							formatting = false,
							rangeFormatting = false,
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
						},
					},
				},
				clangd = {
					init_options = { clangdFileStatus = true },
					filetypes = { "c", "cpp" },
				},
			}

			for _, server_name in ipairs(ensure_installed) do
				local server_config = servers[server_name] or {}

				vim.lsp.config[server_name] = vim.tbl_deep_extend("force", {
					capabilities = capabilities,
					on_attach = on_attach,
				}, server_config)
			end

			require("mason-tool-installer").setup({ ensure_installed = { "stylua" } })

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
		end,
	},
}
