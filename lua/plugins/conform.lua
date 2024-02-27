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
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true
    }
  },
}
