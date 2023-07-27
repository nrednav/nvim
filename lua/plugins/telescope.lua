return {
  'nvim-telescope/telescope.nvim',
  event = "VeryLazy",
  version = '0.1.1',
  dependencies = { {'nvim-lua/plenary.nvim'} },
  init = function()
    -- Mappings
    local map = vim.keymap.set
    local builtin = require("telescope.builtin")

    map("n", "<leader>ff", builtin.find_files, {})
    map("n", "<leader>lg", builtin.live_grep, {})
    map("n", "<leader>fb", builtin.buffers, {})
    map("n", "<leader>fg", builtin.git_files, {})
    map("n", "<leader>vc", function()
      builtin.find_files({
        path_display = { "shorten" },
        cwd = "~/.config/nvim",
        prompt_title = "<- NVIMRC ->",
      })
    end)
  end,
  config = function()
    local telescope = require("telescope")

    -- Setup
    telescope.setup({
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        }
      }
    })

    -- Extensions
    telescope.load_extension("fzf")
  end
}
