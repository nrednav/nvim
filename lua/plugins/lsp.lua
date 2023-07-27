return {
  -- LSP Zero
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    lazy = true,
    config = function()
      require("lsp-zero.settings").preset({})
    end
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = 'LspInfo',
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
      {'williamboman/mason-lspconfig.nvim'},
      {
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.api.nvim_command, 'MasonUpdate')
        end,
      },
    },
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { 'vim' }
              }
            }
          }
        },
        tsserver = {
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
          },
        }
      }
    },
    config = function(_, opts)
      local lsp = require("lsp-zero")
      local lspconfig = require("lspconfig")

      lsp.on_attach(function(_, bufnr)
        local opts = { buffer = bufnr, remap = false }
        local map = vim.keymap.set

        map("n", "gd", function() vim.lsp.buf.definition() end, opts)
        map("n", "gr", function() vim.lsp.buf.references() end, opts)
        map("n", "K", function() vim.lsp.buf.hover() end, opts)
        map("n", "<leader>d", function() vim.diagnostic.open_float() end, opts)
        map("n", "[g", function() vim.diagnostic.goto_prev() end, opts)
        map("n", "]g", function() vim.diagnostic.goto_next() end, opts)
        map("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
      end)

      lsp.ensure_installed({
        "tsserver",
        "eslint",
        "lua_ls",
        "emmet_ls",
        "clangd"
      })

      for server, server_opts in pairs(opts.servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          lspconfig[server].setup(server_opts)
        end
      end

      lsp.set_sign_icons({
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
      })

      lsp.setup()

      vim.diagnostic.config({ virtual_text = true })
    end
  }
}
