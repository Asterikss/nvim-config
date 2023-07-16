local function m(a, b, v)
    vim.keymap.set(a, b, v, { noremap = true })
end

m("n", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

if not vim.fn.has('wsl') then
    m("n", "<Leader>ve", "<cmd>e ~/AppData/Local/nvim/init.vim<CR>")
    m("n", "<Leader>vr", "<cmd>source ~/AppData/Local/nvim/init.vim<CR>")
    m("n", "<Leader><Leader>s", "<cmd>w C:/Users/lono8/Desktop/.txt<Left><Left><Left><Left>")
    m("n", "<C-z>", "<Nop>")
    m("i", "<C-z>", "<Nop>")
    m("t", "<C-z>", "<Nop>")
    m("v", "<C-z>", "<Nop>")
else
    m("n", "<Leader>ve", "<cmd>e ~/.config/nvim/init.lua<CR>")
    m("n", "<Leader>vr", "<cmd>source ~/.config/nvim/init.lua<CR>")
end



m("i", "kj", "<Esc>")

m("v", "y", "myy`y") -- keeps the position of the cursor after v yank

m("n", ";", ":")
m("v", ";", ":")

m("n", ":", ";")

m("n", "x", "\"_x") -- Prevent x from overwriting y's
m("n", "X", "\"_X")

m("v", ">", ">gv")
m("v", "<", "<gv")

m("n", "<Leader><Leader>q", "gqap")
m("v", "<Leader><Leader>q", "gq")

m("n", "n", "nzz") -- :h zw
m("n", "n", "nzz")


-- --terminal--
m("t", "<Ecs>", "<C-/><C-n>")
m("t", "<A-[>", "<Esc>")
m("t", "<A-l>", "<C-/><C-n>gt")
m("t", "<A-h>", "<C-/><C-n>gT")
m("t", "<C-h>", "<C-/><C-n><C-w>h")
m("t", "<C-k>", "<C-/><C-n><C-w>k")
m("t", "<C-u>", "<C-/><C-n><C-u>")

m("n", "<C-t>", ":tabnew ") -- <C-t> has something to do with TagStack

m("n", "go", "o<Esc>k")
m("n", "gO", "O<Esc>j")
-- <A-k> <A-j> does not work. Maby alt first, then...

-- --windows--
m("n", "<Down>", "<c-w>-")
m("n", "<Up>", "<c-w>+")
m("n", "<Left>", "<c-w>>")
m("n", "<Right>", "<c-w><")


m("n", "<C-h>", "<C-w>h")
m("n", "<C-j>", "<C-w>j")
m("n", "<C-k>", "<C-w>k")
m("n", "<C-l>", "<C-w>l")

m("n", "<A-h>", "gT")
m("n", "<A-l>", "gt")

m("i", "<C-e>", "<Esc>A")
m("i", "<C-a>", "<Esc>I")

m("x", "J", "<cmd>m '>+1<CR>gv=gv")
m("x", "K", "<cmd>m '<-2<CR>gv=gv")

m("x", "p", "\"_dP") -- Without trashing the clippboard
m("x", "<A-p>", "p") -- There might be a better way

m("n", "<Leader>y", "\"ay")
m("v", "<Leader>y", "\"ay")
m("n", "<Leader>p", "\"aP") --  <- old p here. Changes the clippboard
m("v", "<Leader>p", "\"aP") -- not sure know how change that

m("n", "<A-d>", "\"_d")     -- Without trashing the clippboard
m("v", "<A-d>", "\"_d")

m("n", "<Leader><Leader>d", "ddO<Esc>")

m("n", "<Leader>l", "<cmd>Lex 25<CR>")
m("n", "<Leader><Leader>l", "<cmd>Tex<CR>")

m("n", "<Leader>a", "g'\"")

m("n", "<Leader>o", "o<C-w>")
m("n", "<Leader>O", "O<C-w>")

m("n", "<c-d>", "<c-d>zz")
m("n", "<c-u>", "<c-u>zz")

m("n", "<A-y>", "Yp")

m("n", "D", "dd")
m("n", "dd", "D")
m("n", "C", "cc")
m("n", "cc", "C")

m("n", "Y", "yy")
m("n", "yy", "y$")

m("i", "q[", " {}<Left><CR><Esc>O")

m("n", "<a-w>", "ZQ")


m("n", "J", "mzJ'z")

-- m("n", "<A-j>", ":tabm -1<CR>")
-- m("n", "<A-k>", ":tabm +1<CR>")

-- Enable spel checking, z=
-- map <leader>s :getlocal spell! spelllang=en_us<CR>

-- for future reference
-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gdt", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>", opts)
-- m("n", "ggt", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>")
m("n", "gd", "<cmd>vsp | lua vim.lsp.buf.definition()<CR>")

-- m("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- function FormatPython()
--     -- vim.cmd("w")
--     -- or vim.fn.expand('%:p') --  .. " >/dev/null 2>&1 &" can be added to the back, but silent makes no diff
--     vim.cmd("silent ! black " .. vim.api.nvim_buf_get_name(0)) -- or vim.fn.expand('%:p')
--     vim.defer_fn(function ()
--         vim.cmd("e")
--     end, 150)
-- end

-- m("n", "<Leader><Leader>n", ":lua FormatPython()")
-- vim.keymap.set("n", "<Leader><Leader>n", ":lua FormatPython()<CR>", { noremap = true,})
-- local function m(a, b, v)
-- 	vim.keymap.set(a, b, v, { noremap = true })
-- end
--
function FormatPython()
    -- vim.cmd("w")
    -- or vim.fn.expand('%:p') --  .. " >/dev/null 2>&1 &" can be added to the back, but silent makes no diff
    -- silent and defer_fn can be removed to get feedback and for the file to be automatically
    -- changed (formatted) after pressing enter / <C-c>
    vim.cmd("silent ! black " .. vim.api.nvim_buf_get_name(0)) -- or vim.fn.expand('%:p')
    vim.defer_fn(function()
        vim.cmd("e")
    end, 150)
end

-- or ~
-- function Format()
--     if vim.bo.filetype == 'rust' then
--         vim.cmd('RustFmt')
--     else
--         vim.cmd('CocCommand prettier.forceFormatDocument')
--     end
-- end
-- map("", "<Leader>f", "<cmd>:lua require('utils').format<CR>")

------ Telescope
m("n", "<Leader>f", function()
    require("telescope.builtin").find_files(require('telescope.themes').get_dropdown {
        previewer = false })
end)
m("n", "<Leader>/", function()
    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
        windblend = 10,
        previewer = false,
    })
end)
m("n", "<Leader><Leader>f", require("telescope.builtin").find_files)
m("n", "<Leader>b", require("telescope.builtin").buffers)
m("n", "<Leader>gg", require("telescope.builtin").live_grep)
m("n", "<Leader>gh", require("telescope.builtin").help_tags)
m("n", "<Leader>?", require("telescope.builtin").oldfiles)
m("n", "<Leader>sd", require("telescope.builtin").diagnostics)
m("n", "<Leader>sw", require("telescope.builtin").grep_string)

----- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- :Telescope builtin
-- m("n", "<Leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false}))<CR>")
-- :Telescope grep_string search=abcd -- fuzzy find over results
-- :Telescope find_files cwd=~/.config/ smth or /code

-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes
-- https://github.com/nvim-telescope/telescope.nvim#default-mappings or use ? in normal mode inside Telescope

-- for future reference
-- https://github.com/neovim/neovim/issues/12642
-- function! Is_WSL() abort
-- let proc_version = '/proc/version'
-- return filereadable(proc_version)
--   \  ? !empty(filter(
--   \    readfile(proc_version, '', 1), { _, val -> val =~? 'microsoft' }))
--   \  : v:false
-- endfunction
