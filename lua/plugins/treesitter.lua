return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "main",
    event = { "BufReadPost", "BufNewFile" },
    enabled = true,
    config = function()
      require("plugins.custom.treesitter").setup()
    end,
  },
}
