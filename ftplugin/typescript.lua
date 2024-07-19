vim.api.nvim_buf_set_keymap(0, "i", "qp", 'console.log();<left><left>', { noremap = true })
vim.api.nvim_buf_set_keymap(0, "i", "qo", " {}<Left><CR><Esc>O", { noremap = true })
