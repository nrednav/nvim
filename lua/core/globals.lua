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
