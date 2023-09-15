-- vim.api.nvim_buf_set_keymap(0, a, b, v, { noremap = true })
-- With nvim_buf_set_keymap everytime a new buffer is opened with .py extension
-- this file will "be sourced again"
-- With normal set it will -> a new buffer with a different file extension, those maps will still work.
-- I am usually working with only one file type during one session
-- vim.api.keymap.set() - https://www.reddit.com/r/neovim/comments/uuh8xw/noob_vimkeymapset_vs_vimapinvim_set_keymap_key/

vim.keymap.set("n", "<Leader><A-y>", "YI#<Space><Esc>p", { noremap = true })
vim.keymap.set("i", "qp", "print()<left>", { noremap = true })
vim.keymap.set("i", "<a-q>p", 'print("")<left><left>', { noremap = true })
vim.keymap.set("i", "qfp", 'print(f"}")<left><left><left>', { noremap = true })
vim.keymap.set("i", ";", ':<CR>', { noremap = true })

-- https://github.com/EgZvor/vim-black
-- https://github.com/averms/black-nvim/tree/master
-- https://github.com/mhartington/formatter.nvim
-- https://github.com/VonHeikemen/lsp-zero.nvi
