local map = vim.keymap.set

map("n", "<leader>fe", ":<C-u>Defx -listed -resume -columns=mark:indent:icon:filename:type:size:time -buffer-name=tab`tabpagenr()` `expand('%:p:h')` -search=`expand('%:p')`<CR>", { silent = true })

vim.api.nvim_create_autocmd('filetype', {
  pattern = "defx",
  desc = "Custom mappings for Defx",
  callback = function()
    local default_opts = {
      noremap = true,
      silent = true,
      expr = true
    }

    -- Open file in current tab
    vim.api.nvim_buf_set_keymap(0, 'n', '<cr>', [[ defx#do_action('open') ]], default_opts)

    -- Open file in new tab
    vim.api.nvim_buf_set_keymap(0, 'n', '<C-t>', [[ defx#do_action('open', 'tabnew') ]], default_opts)

    -- Copy file
    vim.api.nvim_buf_set_keymap(0, 'n', 'c', [[ defx#do_action('copy') ]], default_opts)

    -- Move file
    vim.api.nvim_buf_set_keymap(0, 'n', 'm', [[ defx#do_action('move') ]], default_opts)

    -- Paste file
    vim.api.nvim_buf_set_keymap(0, 'n', 'p', [[ defx#do_action('paste') ]], default_opts)

    -- New file
    vim.api.nvim_buf_set_keymap(0, 'n', 'n', [[ defx#do_action('new_file') ]], default_opts)

    -- New directory
    vim.api.nvim_buf_set_keymap(0, 'n', 'd', [[ defx#do_action('new_directory') ]], default_opts)

    -- Delete
    vim.api.nvim_buf_set_keymap(0, 'n', 'D', [[ defx#do_action('remove') ]], default_opts)

    -- Rename
    vim.api.nvim_buf_set_keymap(0, 'n', 'r', [[ defx#do_action('rename') ]], default_opts)

    -- Show hidden files/directories
    vim.api.nvim_buf_set_keymap(0, 'n', '.', [[ defx#do_action('toggle_ignored_files') ]], default_opts)

    -- Go up one directory
    vim.api.nvim_buf_set_keymap(0, 'n', 'h', [[ defx#do_action('cd', ['..']) ]], default_opts)

    -- Quit Defx
    vim.api.nvim_buf_set_keymap(0, 'n', 'q', [[ defx#do_action('quit') ]], default_opts)
  end
})
