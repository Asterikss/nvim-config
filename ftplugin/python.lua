vim.api.nvim_buf_set_keymap(0, "n", "<Leader><A-y>", "YI#<Space><Esc>p", { noremap = true })
vim.api.nvim_buf_set_keymap(0, "i", "qp", "print()<left>", { noremap = true })
vim.api.nvim_buf_set_keymap(0, "i", "<a-q>p", 'print("")<left><left>', { noremap = true })
vim.api.nvim_buf_set_keymap(0, "i", "qfp", 'print(f"}")<left><left><left>', { noremap = true })
vim.api.nvim_buf_set_keymap(0, "i", ";", ':<CR>', { noremap = true })
vim.api.nvim_buf_set_keymap(0, "i", 'q;', ';', { noremap = true })
-- https://github.com/mhartington/formatter.nvim
-- https://github.com/VonHeikemen/lsp-zero.nvi
