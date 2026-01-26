return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  opts = {
    separate_diagnostic_server = true,
    publish_diagnostic_on = "insert_leave",
    jsx_close_tag = {
      enable = true,
      filetypes = { "javascriptreact", "typescriptreact" }
    },
    expose_as_code_action = {},
    tsserver_path = nil,
    tsserver_plugins = {},
    tsserver_format_options = {},
    tsserver_file_preferences = {
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = true,
      includeInlayVariableTypeHints = true,
      includeInlayVariableTypeHintsWhenTypeMatchesName = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayEnumMemberValueHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeCompletionsForModuleExports = true,
      includeCompletionsForImportStatements = true,
    },
    tsserver_locale = "en",
    complete_function_calls = false,
    include_completions_with_insert_text = true,
    code_lens = "off",
    disable_member_code_lens = true,
    tsserver_max_memory = 12288
  },
}
