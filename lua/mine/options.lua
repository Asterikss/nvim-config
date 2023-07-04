local o = vim.opt
--local g = vim.g

o.number = true
o.relativenumber = true
o.background = "dark"
o.clipboard = "unnamedplus"			-- Copy paste between nvim and everything else
o.hlsearch = false
o.incsearch = true
o.ignorecase = true
o.smartcase = true
o.scrolloff = 8
o.wrap = false
o.termguicolors = true				-- set t_Co=256  set term=xterm-256color
o.splitbelow = true
o.splitright = true
o.lazyredraw = true				-- no redraw while exec macros
o.wildmenu = true
o.textwidth = 0
o.sidescroll = 3
o.signcolumn = "yes"
o.syntax = "on"
o.fileencoding = "UTF-8"

o.ruler = false			            	-- no ruler - e.g. 17,26-49	TOP
o.cmdheight = 1
o.showmode = false		            	-- no --Insert--
o.laststatus = 0
-- nvim 9.0+ o.showcmdloc = last

-- tab stuff (I hate python)
o.smarttab = true
-- o.tabstop = 4
-- o.softtabstop = 4
-- o.shiftwidth = 4
-- o.expandtab = true				-- enter spaces when tab is pressed
-- currently I don't see a difference
-- o.autoindent = true
-- o.smartindent = true

-- vim.cmd [[ augroup cmdline
--     autocmd!
--     autocmd CmdlineLeave : echo ''
-- augroup end ]]	-- you can use :mess to show them or : and arrows

-- o.numberwidth = 4
-- o.breakindent = true
-- o.undofile = true
-- set noswapfile
-- set nobackup
-- set nohidden					-- Unloads abandoned buffers. Still present
-- set path=.,,**				-- Search the dir ur in and recursively all children .Tabf
-- set cursorline
-- set listchars=tab:>\ ,trail:.
-- set guicursor=				-- A square even if in an insert mode

vim.api.nvim_create_autocmd('TextYankPost', {
  -- group = vim.api.nvim_create_augroup('highlight_yank'), -- does not work
  -- desc = 'Hightlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 100 }
  end,
})
-- ~ same as above
-- vim.cmd [[ augroup highlight_yank
--     autocmd!
-- 	au textYankPost * silent! lua vim.highlight.on_yank({"IncSearch", 100})
-- augroup END ]] 


--[[ augroup line_return
	autocmd!
	autocmd BufReadPost *
			\ if line("'\'") > 0 && line("'\'") <= line("$") |
			\ execute 'normal! g'"zvzz' |
			\ endif
	augroup END
]]
