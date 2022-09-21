local o = vim.opt
--local g = vim.g


o.number = true
o.relativenumber = true
o.background = "dark"
o.clipboard = "unnamedplus"			-- Copy paste between nvim and everything else
o.hlsearch = false
o.incsearch = true
o.scrolloff = 8
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.smartindent = true
o.wrap = false
o.termguicolors = true				-- set t_Co=256  set term=xterm-256color
o.splitbelow = true
o.splitright = true
o.lazyredraw = true				-- not redraw while exec macros
o.wildmenu = true
o.textwidth = 0
o.ruler = false
o.showmode = false
o.sidescroll = 2
o.signcolumn = "yes"
vim.cmd('syntax on')
o.ruler = false			-- no ruler - 17,26-49	TOP
o.showmode = false		-- no --Insert--
o.laststatus = 1
-- set statusline=0
-- set noshowcmd  " not sure what this does
-- set shortmess+=F " get rid of the file name.
-- Neovim0.8 set cmdheight=0 - toggle
vim.cmd [[ augroup cmdline
    autocmd!
    autocmd CmdlineLeave : echo ''
augroup end ]]
-- o.numberwidth = 4
-- set noswapfile
-- set nobackup
-- set nohidden					-- Unloads abandoned buffers. Still present
-- set path=.,,**				-- Search the dir ur in and recursively all children .Tabf
-- set cursorline
-- Status bar
-- set laststatus=2
-- set list
-- set listchars=tab:>\ ,trail:.
-- set guicursor=				-- A square even if in an insert moden

-- set noru			-- no ruler - 17,26-49	TOP
-- set noshowmode		-- no --Insert--
-- set statusline=0	
-- set noshowcmd  -- to stop last command from displaying
-- set shortmess+=F get rid of the file name. Do not use now
-- Neovim0.8 set cmdheight=0 - make it a toggle later



