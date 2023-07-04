local fn = vim.fn

-- Automaticly install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path
	})
	print "Installing packer - close and reopen Neovim..."
	PACKER_BOOTSTRAP = true
	-- vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- vim.cmd [[
-- 	augroup packer_user_config
-- 		autocmd!
-- 		autocmd BufWritePost plugins.lua source <afile>	| PackerCompile
-- 	augroup end
-- ]]

-- Use a proteceted call so there is no error during the first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	print "\"require packer failed\""
	return
end


return packer.startup(function(use)
	-- use {"wbthomas/packer.nvim", opt = true}
	use {"wbthomason/packer.nvim"}

	-- Colorscheme
	use "savq/melange"

	-- Comments (requires nvim 0.7+)
	use {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	}
	-- LSP
	use "neovim/nvim-lspconfig"
	use "williamboman/mason-lspconfig.nvim"
	use "williamboman/mason.nvim"

	-- Completion
	use "hrsh7th/nvim-cmp"
	use "hrsh7th/cmp-buffer"
	use "hrsh7th/cmp-path"
	use "saadparwaiz1/cmp_luasnip"
	-- use "L3MON4D3/LuaSnip"

	use "hrsh7th/cmp-nvim-lsp"

	-- Snippets
	use "L3MON4D3/LuaSnip"
	use "rafamadriz/friendly-snippets"

	-- Telescope
	use {
		'nvim-telescope/telescope.nvim',
		-- , tag = '0.1.0',
		-- or
		branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	-- Treesitter 
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		-- requires = { {'nvim-treesitter/nvim-treesitter-textobjects'} }
		--
		-- use({
		-- 	"nvim-treesitter/nvim-treesitter-textobjects",
		-- 	after = "nvim-treesitter",
		-- 	requires = "nvim-treesitter/nvim-treesitter",
		-- })
	}

	-- use "nvim-telescope/telescope.nvim"
	-- BurntSushi/ripgrep is required for live_grep and grep_string and is the first priority for find_files
	-- Debian/Ubuntu -> $ curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
	-- $ sudo dpkg -i ripgrep_13.0.0_amd64.deb
	-- Windows -> choco install ripgrep

	-- native telescope sorter to significantly improve sorting performance
	-- requirements:
	-- 1. With Make (Linux, MacOS, Windows with MinGW):
	-- gcc or clang and make
	-- 2. With CMake (Windows, Linux, MacOS):
	--	a) CMake, and the Microsoft C++ Build Tools on Windows
	--	b) CMake, make, and GCC or Clang on Linux and MacOS
	-- Using 1 option. For 2 option -> 
	-- use {'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
	-- use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1}
	use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}

	-- sharkdp/fd is another external dependency that improves smth. Check :checkhealf telescope
	--
	-- "Note that the binary is called fdfind as the binary name fd is already
	-- used by another package. It is recommended that after installation, you
	-- add a link to fd by executing command ln -s $(which fdfind)
	-- ~/.local/bin/fd, in order to use fd in the same way as in this
	-- documentation. Make sure that $HOME/.local/bin is in your $PATH."
	--
	-- Did not do this -^-

	-----

	--Autommaticly set up your configuration after cloning packer.nvim
	--Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)


