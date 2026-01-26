return {
  "saghen/blink.cmp",
  dependencies = { "L3MON4D3/LuaSnip" },
  version = "*",
  event = "InsertEnter",
  opts = {
    keymap = { preset = "default" },
    appearance = {
      nerd_font_variant = "mono",
    },
    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      menu = { auto_show = true },
      ghost_text = { enabled = true },
    },
    signature = { enabled = true },
    snippets = {
      preset = 'luasnip'
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}
