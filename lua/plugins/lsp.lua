return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      { "j-hui/fidget.nvim",                           opts = {} },
      { "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "b0o/SchemaStore.nvim",
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          local builtin = require("telescope.builtin")
          local opts = { buffer = event.buf, noremap = true, silent = true }

          -- Navigation
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gr", builtin.lsp_references, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, opts)

          -- Actions
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>wd", builtin.lsp_document_symbols, opts)

          -- Diagnostics
          vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
          vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "]g", vim.diagnostic.goto_next, opts)

          -- Verify Attachment (Optional Debug)
          -- local client = vim.lsp.get_client_by_id(event.data.client_id)
          -- print("LSP attached: " .. client.name)
        end,
      })

      -- =======================================================================
      -- 2. CAPABILITIES & MASON SETUP
      -- =======================================================================
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      require("mason").setup()
      require("mason-tool-installer").setup({
        ensure_installed = { "clangd", "codelldb", "clang-format" },
      })

      -- =======================================================================
      -- 3. SERVER DEFINITIONS
      -- =======================================================================
      local servers = {
        bashls = {},
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
              diagnostics = { globals = { "vim" } },
            },
          },
        },
        yamlls = {
          settings = {
            on_attach = function(client)
              client.server_capabilities.documentFormattingProvider = false
            end,
            yaml = {
              schemaStore = { enable = false, url = "" },
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
        -- Note: clangd is handled manually below to ensure flag correctness
      }

      -- =======================================================================
      -- 4. AUTOMATIC CONFIGURATION (Mason Handlers)
      -- =======================================================================
      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(servers),
        handlers = {
          function(server_name)
            local config = servers[server_name] or {}

            config.capabilities = capabilities

            vim.lsp.config(server_name, config)
            vim.lsp.enable(server_name)
          end,
        },
      })

      -- =======================================================================
      -- 5. MANUAL CLANGD SETUP (The "Nuclear" Override)
      -- We keep this separate to guarantee your custom flags work.
      -- =======================================================================
      vim.lsp.config("clangd", {
        capabilities = capabilities,
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
      })
      vim.lsp.enable("clangd")

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

      -- =======================================================================
      -- 6. UI POLISH
      -- =======================================================================
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
