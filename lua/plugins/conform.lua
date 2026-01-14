return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "[F]ormat buffer",
    },
  },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        cpp = { "clang-format" },
        c = { "clang-format" },
        lua = { "stylua" },
      },
      format_on_save = function(bufnr)
        -- Disable autoformat for specific buffers if needed
        if vim.g.conform_disable_autoformat or vim.b[bufnr].conform_disable_autoformat then
          return
        end
        return {
          timeout_ms = 500,
          lsp_fallback = true,
        }
      end,
    })

    vim.api.nvim_create_user_command("ConformDisable", function(args)
      if args.bang then
        vim.b.conform_disable_autoformat = true
      else
        vim.g.conform_disable_autoformat = true
      end
    end, { desc = "Disable autoformat-on-save", bang = true })

    vim.api.nvim_create_user_command("ConformEnable", function()
      vim.b.conform_disable_autoformat = false
      vim.g.conform_disable_autoformat = false
    end, { desc = "Enable autoformat-on-save" })
  end,
}
