vim.api.nvim_buf_set_option(0, 'tabstop', 4)
vim.api.nvim_buf_set_keymap(0, 'i', 'qp', 'print()<left>', { noremap = true })
vim.api.nvim_buf_set_keymap(0, 'i', '<a-q>p', 'print("")<left><left>', { noremap = true })
vim.api.nvim_buf_set_keymap(0, 'i', 'qfp', 'print(f"{=}")<left><left><left><left>', { noremap = true })
vim.api.nvim_buf_set_keymap(0, 'i', 'qffp', 'print(f"}")<left><left><left>', { noremap = true })
vim.api.nvim_buf_set_keymap(0, 'i', ';', '<End>:<CR>', { noremap = true })
vim.api.nvim_buf_set_keymap(0, 'i', 'q;', ';', { noremap = true })
vim.api.nvim_buf_set_keymap(0, 'x', '<Leader>cp', ':g/print/s/^/#/\r', { noremap = true }) -- comment all lines starting with print
-- https://github.com/mhartington/formatter.nvim
-- https://github.com/VonHeikemen/lsp-zero.nvi
