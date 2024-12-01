vim.api.nvim_buf_set_keymap(0, 'i', 'qp', 'console.log();<left><left>', { noremap = true })
vim.api.nvim_buf_set_keymap(0, 'i', 'qo', '<End> {}<Left><CR><Esc>O', { noremap = true })
vim.api.nvim_buf_set_keymap(0, 'i', '"', "'", { noremap = true })
vim.api.nvim_buf_set_keymap(0, 'i', "'", '"', { noremap = true })
