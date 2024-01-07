local os = vim.loop.os_uname().sysname;

-- Set leader key
vim.g.mapleader = ","

-- Set path to python binary
if os == "Darwin" then
  vim.g.python3_host_prog='/opt/homebrew/bin/python3'
else
  vim.g.python3_host_prog='/usr/bin/python3.12'
end
