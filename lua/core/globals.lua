local function get_python_path()
  if vim.env.NVIM_PYTHON_PATH then
    return vim.env.NVIM_PYTHON_PATH
  end

  local os_name = vim.uv.os_uname().sysname

  if os_name == "Darwin" then
    -- macOS
    return "/opt/homebrew/bin/python3.11"
  elseif os_name == "Linux" then
    -- WSL sets 'WSL_DISTRO_NAME' (and others) automatically.
    if vim.env.WSL_DISTRO_NAME then
      return "/usr/bin/python3" -- WSL Python path
    end

    return "/usr/bin/python" -- Standard Linux path
  else
    -- Fallback for other systems
    return "/usr/bin/python"
  end
end

-- Set leader key
vim.g.mapleader = ","

-- Set python path dynamically
vim.g.python3_host_prog = get_python_path()

-- Make asdf-managed toolchains (e.g. Go) visible to Neovim, no matter how
-- Neovim was launched (terminal, GUI, or a bare shell).
-- This runs before any plugin loads, so Mason can find `go` when it installs
-- gopls, and gopls can find its GOROOT when it runs.
do
  local asdf_dir = vim.env.ASDF_DATA_DIR or (vim.env.HOME .. "/.asdf")
  local shims = asdf_dir .. "/shims"
  local bin = asdf_dir .. "/bin"
  local path = vim.env.PATH or ""
  if vim.uv.fs_stat(shims) and not path:find(shims, 1, true) then
    vim.env.PATH = shims .. ":" .. bin .. ":" .. path
  end
end
