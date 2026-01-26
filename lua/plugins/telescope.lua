return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  branch = "master",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-smart-history.nvim",
    "kkharji/sqlite.lua",
  },
  init = function()
    local function ivy(builtin_name, opts)
      return function()
        local builtin = require("telescope.builtin")
        local themes = require("telescope.themes")
        builtin[builtin_name](themes.get_ivy(opts or {}))
      end
    end

    vim.keymap.set("n", "<leader>ff", ivy("find_files"))
    vim.keymap.set("n", "<leader>fh", ivy("help_tags"))
    vim.keymap.set(
      "n",
      "<leader>fn",
      ivy("find_files", {
        cwd = "~/docs/blue",
        prompt_title = "<- NOTES ->",
      })
    )
    vim.keymap.set("n", "<leader>lg", function()
      local themes = require("telescope.themes")
      require("plugins.custom.telescope.multi-ripgrep")(themes.get_ivy({}))
    end)
    vim.keymap.set("n", "<leader>fb", ivy("current_buffer_fuzzy_find"))
    vim.keymap.set(
      "n",
      "<leader>fp",
      ivy("find_files", {
        cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"),
      })
    )
    vim.keymap.set("n", "<leader>fg", ivy("git_files"))
    vim.keymap.set(
      "n",
      "<leader>vc",
      ivy("find_files", {
        path_display = { "shorten" },
        cwd = "~/.config/nvim",
        prompt_title = "<- NVIMRC ->",
      })
    )
  end,
  config = function()
    local data = assert(vim.fn.stdpath("data"))

    require("telescope").setup({
      defaults = {
        file_ignore_patterns = {
          "vcpkg",
          "vcpkg_installed",
          "build",
          "%.git/",
          "%.cache",
          "%.DS_Store",
        }
      },
      extensions = {
        wrap_results = true,
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        history = {
          path = vim.fs.joinpath(data, "telescope_history.sqlite3"),
          limit = 100,
        },
      },
    })

    require("telescope").load_extension("fzf")
    require("telescope").load_extension("smart_history")
  end,
}
