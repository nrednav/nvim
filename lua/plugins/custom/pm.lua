local M = {}

local PROJECTS_DIR = vim.fn.expand("~/docs/projects")
local ARCHIVE_DIR = "_archive"
local WIP_LIMIT = 3

M.find_active_tasks = function()
  require("telescope.builtin").grep_string({
    prompt_title = "PROJECTS :: ACTIVE (#now)",
    cwd = PROJECTS_DIR,
    search = "#now",
    file_ignore_patterns = { ARCHIVE_DIR },
    path_display = { "shorten" },
    only_sort_text = true
  })
end

M.find_project_manifests = function()
  require("telescope.builtin").find_files({
    prompt_title = "PROJECTS :: MANIFESTS",
    cwd = PROJECTS_DIR,
    file_ignore_patterns = { ARCHIVE_DIR },
    find_command = { "rg", "--files", "--glob", "**/manifest.md" }
  })
end

M.browse_all_files = function()
  require("telescope.builtin").find_files({
    prompt_title = "PROJECTS :: ALL FILES",
    cwd = PROJECTS_DIR,
    file_ignore_patterns = { ARCHIVE_DIR },
  })
end

M.check_wip = function()
  local cmd = "rg -c '#now' " .. PROJECTS_DIR .. " -g '!" .. ARCHIVE_DIR .. "' | awk -F: '{s+=$2} END {print s}'"
  local handle = io.popen(cmd)
  local result = handle:read("*a")

  handle:close()

  local count = tonumber(result) or 0

  if count > WIP_LIMIT then
    vim.notify("⚠️ Overload: " .. count .. " tasks.", vim.log.levels.WARN)
  else
    vim.notify("✅ Nominal: " .. count .. " tasks.", vim.log.levels.INFO)
  end
end

return M
