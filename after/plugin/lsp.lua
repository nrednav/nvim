local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  "tsserver",
  "eslint",
  "lua_ls",
  "emmet_ls",
  "clangd"
})

-- Server Configs

-- tsserver
lsp.configure("tsserver", {
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
})

lsp.nvim_workspace()

-- Completion
local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ['<C-Space>'] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

-- Preferences
lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
  }
})

-- Mappings
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

lsp.setup()

vim.diagnostic.config({
  virtual_text = true
})
