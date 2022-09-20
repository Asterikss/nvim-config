-- nvim v 0.7+
local function m(a, b, v)
	vim.keymap.set(a, b, v, { noremap = true })
end

m("n", "<Space>", "<Nop>")
--m("", "<Space>", "<Nop>")
--vim.cmd("noremap <Space> <Nop>")

vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- m("n", "<Space>", "<Leader>") -- does not work

if not vim.fn.has('wsl') then
	m("n", "<Leader>ve", ":e ~/AppData/Local/nvim/init.vim<CR>")
	m("n", "<Leader>vr", ":source ~/AppData/Local/nvim/init.vim<CR>")
	m("n", "<Leader>s", ":w C:/Users/lono8/Desktop/.txt<Left><Left><Left><Left>")
	m("n", "<C-z>", "<Nop>")
	m("i", "<C-z>", "<Nop>")
	m("t", "<C-z>", "<Nop>")
	m("v", "<C-z>", "<Nop>")
else
	m("n", "<Leader>ve", "<cmd>e ~/.config/nvim/init.lua<CR>")
	m("n", "<Leader>vr", "<cmd>source ~/.config/nvim/init.lua<CR>")
end

--https://github.com/neovim/neovim/issues/12642
--function! Is_WSL() abort
--let proc_version = '/proc/version'
--return filereadable(proc_version)
--	  \  ? !empty(filter(
--	  \    readfile(proc_version, '', 1), { _, val -> val =~? 'microsoft' }))
--	  \  : v:false
--endfunction


m("i", "kj", "<Esc>")

m("n", "Y", "yy")
m("v", "y", "myy`y")

m("n", ";", ":")
m("v", ";", ":")

m("n", ":", ";")

-- Prevent x from overwriting y's
m("n", "x", "\"_x")
m("n", "X", "\"_X")

m("v", ">", ">gv")
m("v", "<", "<gv")

m("n", "<Leader>g", "gqap")
m("v", "<Leader>g", "gq")

m("n", "n", "nzz")
m("n", "n", "nzz")


-- --terminal--
m("t", "<Ecs>", "<C-/><C-n>")
m("t", "<A-[>", "<Esc>")
m("t", "<A-l>", "<C-/><C-n>gt")
m("t", "<A-h>", "<C-/><C-n>gT")
m("t", "<C-h>", "<C-/><C-n><C-w>h")
m("t", "<C-k>", "<C-/><C-n><C-w>k")
m("t", "<C-u>", "<C-/><C-n><C-u>")

m("n", "<C-t>", "<cmd>tabnew ")
--k("n", "<C-t>", ":tabnew<Space>", opts)
-- k("n", "<C-T>", ":tabnew<CR>", opts)
-- <C-t> has something to do with TagStack
-- Possible to put for instance .cpp at the end
-- inoremap <C-t> <Esc>:tabnew<CR>

m("n", "go", "o<Esc>k")
m("n", "gO", "O<Esc>j")
-- <A-m> <A-j> does not work. Maby alt first, then...

-- --windows--
m("n", "<Down>",  "<cmd>resize -2<CR>")
m("n", "<Up>",    "<cmd>resize +2<CR>")
m("n", "<Left>",  "<cmd>vertival resize +2<CR>")
m("n", "<Right>", "<cmd>vertival resize -1<CR>")


m("n", "<C-h>", "<C-w>h")
m("n", "<C-j>", "<C-w>j")
m("n", "<C-k>", "<C-w>k")
m("n", "<C-l>", "<C-w>l")

m("n", "<A-h>", "gT")
m("n", "<A-l>", "gt")

m("i", "<C-a>", "<Esc>A")
m("i", "<C-e>", "<Esc>I")

m("x", "<A-j>", "<cmd>m '>+1<CR>gv")
m("x", "<A-k>", "<cmd>m '<-2<CR>gv")

m("v", "p", "\"_dP")

m("n", "<Leader>l", "<cmd>Lex 25<CR>")

-- local opts = { noremap = true, silent = false }
-- local k = vim.api.nvim_set_keymap
