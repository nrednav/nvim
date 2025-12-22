return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "*",
	lazy = false,
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
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			providers = {
				lsp = {
					name = "LSP",
					module = "blink.cmp.sources.lsp",
					fallbacks = {},
				},
				buffer = {
					name = "Buffer",
					module = "blink.cmp.sources.buffer",
					min_keyword_length = 2,
				},
				snippets = {
					name = "Snippets",
					module = "blink.cmp.sources.snippets",
				},
				path = {
					name = "Path",
					module = "blink.cmp.sources.path",
					score_offset = 3,
				},
			},
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
