local o = vim.opt

o.number = true
o.relativenumber = true
o.hlsearch = false
o.incsearch = true
o.ignorecase = true
o.smartcase = true
o.scrolloff = 8
o.wrap = false
o.termguicolors = true -- set t_Co=256  set term=xterm-256color
o.splitbelow = true
o.splitright = true
o.lazyredraw = true
o.wildmenu = true
o.textwidth = 0
o.sidescroll = 3
o.timeoutlen = 700
o.background = "dark"
o.clipboard = "unnamedplus"
o.signcolumn = "yes"
o.syntax = "on"
o.fileencoding = "UTF-8"
o.completeopt = 'menuone,noselect,preview' -- check the behaviour later
o.shortmess:append "IW"                    -- disable nvim intro
o.jumpoptions:append "stack"
o.inccommand = "split"

o.ruler = false
o.cmdheight = 0
o.showmode = false
o.laststatus = 0
o.showcmdloc = "tabline"

-- tab stuff
o.smarttab = true
o.expandtab = true
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.autoindent = true
o.smartindent = true

-- currently I don't see a difference
o.autoindent = false
-- o.smartindent = true -- default off - better for c style langs
o.list = true
vim.opt.listchars = {
    trail = "»", -- trailing spaces ▷ ⦿ ➤ ⊙ •
    -- space = "·", -- spaces
    -- eol = "↴", -- end of line
    -- tab = "»·", -- tabs
    -- extends = "→", -- overflowing text
    -- precedes = "←" -- precedes the window
}

-- o.breakindent = true
-- o.numberwidth = 4
-- o.undofile = true
-- set noswapfile
-- set nobackup
-- set nohidden					-- Unloads abandoned buffers. Still present
-- set path=.,,**				-- Search the dir ur in and recursively all children .Tabf
-- set cursorline
-- set listchars=tab:>\ ,trail:.

-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({timeout = 90}) -- higroup = 'IncSearch'
  end,
  group = highlight_group,
  pattern = '*',
})
-- vim.cmd [[ augroup cmdline
--     autocmd!
--     autocmd CmdlineLeave : echo ''
-- augroup end ]]	-- you can use :mess to show them or : and arrows

--[[ augroup line_return
	autocmd!
	autocmd BufReadPost *
			\ if line("'\'") > 0 && line("'\'") <= line("$") |
			\ execute 'normal! g'"zvzz' |
			\ endif
	augroup END
]]
