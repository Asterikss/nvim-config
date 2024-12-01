vim.opt_local.formatoptions:remove({ 'r', 'o' })
vim.api.nvim_buf_set_keymap(0, 'i', '"', "'", { noremap = true })
vim.api.nvim_buf_set_keymap(0, 'i', "'", '"', { noremap = true })
