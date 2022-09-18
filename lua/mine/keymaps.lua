local opts = { noremap = true, silent = false } 
local k = vim.api.nvim_set_keymap

-- nvim v 07 needed
local function map(m, k, v)
	vim.keymap.set(m, k, v, { noremap = true })
end
--vim.cmd("noremap <Space> <Nop>")
--map("n", "<Space>", "<Nop>")
--map("", "<Space>", "<Nop>")
--map("", "<Leander>", "<Space>")

k("n", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

if not vim.fn.has('wsl') then
	k("n", "<Leader>ve", ":e ~/AppData/Local/nvim/init.vim<CR>", opts)
	k("n", "<Leader>vr", ":source ~/AppData/Local/nvim/init.vim<CR>", opts)
	k("n", "<Leader>s", ":w C:/Users/lono8/Desktop/.txt<Left><Left><Left><Left>", opts)
	k("n", "<C-z>", "<Nop>", opts)
	k("i", "<C-z>", "<Nop>", opts)
	k("t", "<C-z>", "<Nop>", opts)
	k("v", "<C-z>", "<Nop>", opts)
else
	k("n", "<Leader>ve", ":e ~/.config/nvim/init.lua<CR>", opts)
	k("n", "<Leader>vr", ":source ~/.config/nvim/init.lua<CR>", opts)
end

--https://github.com/neovim/neovim/issues/12642
--function! Is_WSL() abort
--let proc_version = '/proc/version'
--return filereadable(proc_version)
--	  \  ? !empty(filter(
--	  \    readfile(proc_version, '', 1), { _, val -> val =~? 'microsoft' }))
--	  \  : v:false
--endfunction


k("i", "kj", "<Esc>", opts)

k("n", "Y", "yy", opts)
k("v", "y", "myy`y", opts)

k("n", ";", ":", opts)
k("v", ";", ":", opts)

k("n", ":", ";", opts)

-- Prevent x from overwriting y's
k("n", "x", "\"_x", opts)
k("n", "X", "\"_X", opts)
 
k("v", ">", ">gv", opts)
k("v", "<", "<gv", opts)

k("n", "<Leader>g", "gqap", opts)
k("v", "<Leader>g", "gq", opts)

k("n", "n", "nzz", opts)
k("n", "N", "Nzz", opts)


-- --terminal--
k("t", "<Ecs>", "<C-/><C-n>", opts)
k("t", "<A-[>", "<Esc>", opts)
k("t", "<A-l>", "<C-/><C-n>gt", opts)
k("t", "<A-h>", "<C-/><C-n>gT", opts)
k("t", "<C-h>", "<C-/><C-n><C-w>h", opts)
k("t", "<C-k>", "<C-/><C-n><C-w>k", opts)
k("t", "<C-u>", "<C-/><C-n><C-u>", opts)

k("n", "<C-t>", ":tabnew ", opts)
--k("n", "<C-t>", ":tabnew<Space>", opts)
-- k("n", "<C-T>", ":tabnew<CR>", opts)
-- <C-t> has something to do with TagStack
-- Possible to put for instance .cpp at the end
-- inoremap <C-t> <Esc>:tabnew<CR>

k("n", "go", "o<Esc>k", opts)
k("n", "gO", "O<Esc>j", opts)
-- <A-k> <A-j> does not work. Maby alt first, then...

-- --windows--
k("n", "<Down>",  ":resize -2<CR>", opts)
k("n", "<Up>",    ":resize +2<CR>", opts)
k("n", "<Left>",  ":vertival resize +2<CR>", opts)
k("n", "<Right>", ":vertival resize -1<CR>", opts)


k("n", "<C-h>", "<C-w>h", opts)
k("n", "<C-j>", "<C-w>j", opts)
k("n", "<C-k>", "<C-w>k", opts)
k("n", "<C-l>", "<C-w>l", opts)

k("n", "<A-h>", "gT", opts)
k("n", "<A-l>", "gt", opts)

k("i", "<C-a>", "<Esc>A", opts)
k("i", "<C-e>", "<Esc>I", opts)

k("x", "<A-j>", ":m '>+1<CR>gv", opts)
k("x", "<A-k>", ":m '<-2<CR>gv", opts)

k("v", "p", "\"_dP", opts)

k("n", "<Leader>e", ":Lex 25<CR>", opts)

