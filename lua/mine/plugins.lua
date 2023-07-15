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

	-- Colorschemes
	use "savq/melange"
    use "folke/tokyonight.nvim"

	-- Comments
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

    -- Useful status updates for LSP
    -- NOTE for "lazy": `opts = {}` is the same as calling `require('fidget').setup({})`
    use {
            'j-hui/fidget.nvim',
            tag = 'legacy',
            config = function()
                require("fidget").setup{}
            end,
    }

	-- Completion
	use "hrsh7th/nvim-cmp"
	use "hrsh7th/cmp-buffer"
	use "hrsh7th/cmp-path"
	use "saadparwaiz1/cmp_luasnip"
	use "hrsh7th/cmp-nvim-lsp"

	-- Snippets
	use {
        "L3MON4D3/LuaSnip",
        require = { { "rafamadriz/friendly-snippets"  } },
    }
	-- use "rafamadriz/friendly-snippets"

	-- Telescope
	use {
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'}, {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'} }
                -- use {'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
	}

	-- Treesitter 
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
        -- don't care now
		-- requires = { {'nvim-treesitter/nvim-treesitter-textobjects'} }
		--
		-- use({
		-- 	"nvim-treesitter/nvim-treesitter-textobjects",
		-- 	after = "nvim-treesitter",
		-- 	requires = "nvim-treesitter/nvim-treesitter",
		-- })
	}

    -- Unless you are still migrating, remove the deprecated commands from v1.x. run :Neotree
    -- vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
    --
    -- use {
    --     "nvim-neo-tree/neo-tree.nvim",
    --     branch = "v2.x",
    --     requires = {
    --         "nvim-lua/plenary.nvim",
    --         -- "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    --         "MunifTanjim/nui.nvim",
    --     }
    -- }

    -- use "tpope/vim-sleuth" Detect tabstop and shiftwidth automatically
    -- mbbill/undotree
    -- tpope/vim-fugitive
    -- nvim-neo-tree/neo-tree.nvim  /  vim-gitgutter  /  oil.nvim  /  harpoon
    -- nvim-telescope/telescope-project.nvim
    -- incorporate git stuff later https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua#LL248

    --[[ { this setup is for "lazy"
            -- Add indentation guides even on blank lines
            'lukas-reineke/indent-blankline.nvim',
            -- Enable `lukas-reineke/indent-blankline.nvim`
            -- See `:help indent_blankline.txt`
            opts = {
                    char = '┊',
                    show_trailing_blankline_indent = false,
            },
    }, ]]


	-- for "nvim-telescope/telescope.nvim"
	-- BurntSushi/ripgrep is required for live_grep and grep_string and is the first priority for find_files
	-- Debian/Ubuntu -> $ curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
	-- $ sudo dpkg -i ripgrep_13.0.0_amd64.deb
	-- Windows -> choco install ripgrep

	--Autommaticly set up your configuration after cloning packer.nvim
	--Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
