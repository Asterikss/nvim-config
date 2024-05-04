vim.api.nvim_buf_set_keymap(0, "n", "<Leader><A-y>", "YI//<Space><Esc>p", { noremap = true })
vim.api.nvim_buf_set_keymap(0, "i", "qo", " {}<Left><CR><Esc>O", { noremap = true })
