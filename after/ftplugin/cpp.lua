vim.api.nvim_buf_set_option(0, "tabstop", 2)
vim.api.nvim_buf_set_keymap(0, "i", "qp", 'std::cout << ;<left>', { noremap = true })
vim.api.nvim_buf_set_keymap(0, "i", "<a-q>p", 'std::cout << "";<left><left>', { noremap = true })
vim.api.nvim_buf_set_keymap(0, "i", "qo", " {}<Left><CR><Esc>O", { noremap = true })
