-- https://stackoverflow.com/questions/72984648/neovim-lua-how-to-use-different-mappings-depending-on-file-type
-- :h ftplugin
-- m could be global(from an import)
-- local map = require("utils").map
local function m(a, b, v)
    -- vim.keymap.set(a, b, v, { noremap = true })
    -- vim.api.keymap.set() - https://www.reddit.com/r/neovim/comments/uuh8xw/noob_vimkeymapset_vs_vimapinvim_set_keymap_key/
    -- could be using noraml set to get a tiny improvement to performence, but after opening
    -- e.g a new buffer with a different file extension, those maps will still work.
    -- That beeing said with nvim_buf_set_keymap everytime a new buffer is opened with .py extension
    -- this file will "be sourced again"

    -- vim.api.nvim_buf_set_keymap(0, a, b, v, { noremap = true })
    -- I am usually working with only one file type during one session
    vim.keymap.set(a, b, v, { noremap = true })
end

m("n", "<Leader><A-y>", "YI#<Space><Esc>p")
m("i", "qp", "print(\"\")<left><left>")
m("i", "<c-q>p", "print()<left>")

m("n", "<Leader><Leader>o", "<cmd>lua FormatPython()<CR>")
-- https://github.com/EgZvor/vim-black
-- https://github.com/averms/black-nvim/tree/master
-- https://github.com/mhartington/formatter.nvim
-- https://github.com/VonHeikemen/lsp-zero.nvi
