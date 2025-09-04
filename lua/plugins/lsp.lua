return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Core Dependencies
			"williamboman/mason.nvim",

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

			local capabilities = nil
			if pcall(require, "cmp_nvim_lsp") then
				capabilities = require("cmp_nvim_lsp").default_capabilities()
			end

			require("mason").setup()

			local servers = {
				bashls = {},
				clangd = {},
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							diagnostics = { globals = { "vim" } },
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
				ts_ls = {
					root_dir = require("lspconfig").util.root_pattern("package.json"),
				},
				biome = {
					root_dir = require("lspconfig").util.root_pattern("biome.json", "package.json"),
				},
			}

			for server_name, server_config in pairs(servers) do
				local final_config = vim.tbl_deep_extend("force", {
					on_attach = on_attach,
					capabilities = capabilities,
				}, server_config)

				require("lspconfig")[server_name].setup(final_config)
			end

			require("mason-tool-installer").setup({
				ensure_installed = { "stylua" },
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
		end,
	},
}
