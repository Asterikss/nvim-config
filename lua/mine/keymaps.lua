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

--https://github.com/neovim/neovim/issues/12642
--function! Is_WSL() abort
--let proc_version = '/proc/version'
--return filereadable(proc_version)
--	  \  ? !empty(filter(
--	  \    readfile(proc_version, '', 1), { _, val -> val =~? 'microsoft' }))
--	  \  : v:false
--endfunction


m("i", "kj", "<Esc>")

m("v", "y", "myy`y")

m("n", ";", ":")
m("v", ";", ":")

m("n", ":", ";")

-- Prevent x from overwriting y's
m("n", "x", "\"_x")
m("n", "X", "\"_X")

m("v", ">", ">gv")
m("v", "<", "<gv")

m("n", "<Leader>w", "gqap")
m("v", "<Leader>w", "gq")

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

-- not a <cmd> command; must end with <CR>
m("n", "<C-t>", ":tabnew ")
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

m("i", "<C-e>", "<Esc>A")
m("i", "<C-a>", "<Esc>I")

m("x", "<A-j>", "<cmd>m '>+1<CR>gv")
m("x", "<A-k>", "<cmd>m '<-2<CR>gv")

m("x", "p", "\"_dP")	 -- Without trashing the clippboard
m("x", "<A-p>", "p")	 -- There might be a better way

m("n", "<Leader>y", "\"ay")
m("v", "<Leader>y", "\"ay")
m("n", "<Leader>p", "\"aP")  -- old p here. Changes the clippboard
m("v", "<Leader>p", "\"aP")	 -- not sure know how change that

m("n", "<A-d>", "\"_d")  -- Without trashing the clippboard
m("v", "<A-d>", "\"_d")

m("n", "<Leader>d", "ddO<Esc>")

m("n", "<Leader>l", "<cmd>Lex 25<CR>")
m("n", "<Leader><Leader>l", "<cmd>Tex<CR>")

m("n", "<Leader>a", "g'\"")	-- <Leader>r is very slow for some reason

m("n", "<Leader>o", "o<C-w>")
m("n", "<Leader>O", "O<C-w>")

m("n", "<A-y>", "Yp")
-- m("n", "<Leader><A-y>", "YI//<Esc>p") for every filetype

m("n", "D", "dd")
m("n", "dd", "D")

m("n", "Y", "yy")
m("n", "yy", "y$")

m("i", "q[", " {}<Left><CR><Esc>O")


-- m("n", "<A-j>", ":tabm -1<CR>")
-- m("n", "<A-k>", ":tabm +1<CR>")

-- Enable spel checking, z=
-- map <leader>s :getlocal spell! spelllang=en_us<CR>




------ Telescope
m("n", "<Leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false}))<CR>")
m("n", "<Leader><Leader>f", "<cmd>lua require'telescope.builtin'.find_files()<CR>")
m("n", "<Leader>s", "<cmd>lua require'telescope.builtin'.buffers()<CR>")
m("n", "<Leader>gg", "<cmd>lua require'telescope.builtin'.live_grep()<CR>")
m("n", "<Leader>gh", "<cmd>lua require('telescope.builtin').help_tags()<CR>")
-- :Telescope grep_string search=abcd -- fuzzy find over results 
-- :Telescope find_files cwd=~/.config/ smth or /code 

-- I dont know what windblend does. e.g windblend = 10. I see no change
-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes
-- https://github.com/nvim-telescope/telescope.nvim#default-mappings or use ? in normal mode inside Telescope
-- maby change slelection from <CR> to <C-k> or smth
-- if I am in normal mode I can use e.g. CTRL-j to leave
------

-- Reference. "Bedore nvim 0.7"
-- local opts = { noremap = true, silent = false }
-- local k = vim.api.nvim_set_keymap
