local api = vim.api

-- Remove all trailing whitespace on save
local TrimWhitespaceGroup = api.nvim_create_augroup("TrimWhitespaceGroup", { clear = true })
api.nvim_create_autocmd("BufWritePre", {
  command = [[:%s/\s\+$//e]],
  group = TrimWhitespaceGroup,
})

-- Disable auto-commenting on new lines
api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })
