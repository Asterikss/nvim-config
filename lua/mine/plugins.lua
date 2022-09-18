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
	vim.cmd [[packadd packer.nvim]]
end

--Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile>	| PackerCompile
	augroup end
]]

--Use a proteceted call so there is no error during the first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	print "\"require packer failed\""
	return
end


return packer.startup(function(use)
	--use {"wbthomas/packer.nvim", opt = true}
	use {"wbthomason/packer.nvim"}

	--colorscheme
	use "savq/melange"

	--comments (requires nvim 0.7+)
	use {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	}

	--Completion
	use "hrsh7th/nvim-cmp"
	use "hrsh7th/cmp-buffer"
	use "hrsh7th/cmp-path"
	use "saadparwaiz1/cmp_luasnip"
	
	--Snippets
	use "L3MON4D3/LuaSnip"
	use "rafamadriz/friendly-snippets"

	--Autommaticly set up your configuration after cloning packer.nvim
	--Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)

