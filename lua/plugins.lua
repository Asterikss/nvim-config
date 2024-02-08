vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Colorschemes
	"savq/melange",
	"folke/tokyonight.nvim",
    {
        'navarasu/onedark.nvim',
        priority = 1000,
        config = function()
            -- vim.cmd.colorscheme 'onedark'
            require('onedark').setup {
                style = 'deep'
            }
            require('onedark').load()
        end,
    },
    -- Comments
    {
        'numToStr/Comment.nvim',
        opts = {
            toggler = {
                line = 'q',
                block = 'gbq',
            },
            opleader = {
                line = 'q',
                block = 'gb',
            },
        },
        lazy = false,
    },
    -- LSP
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
            'folke/neodev.nvim',
        },

     },
	-- Completion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            -- Snippet engine and its associated nvim-cmp source
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",

            -- Adds LSP completion capabilities
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",

            -- Adds a number of snippets
            "rafamadriz/friendly-snippets",
        },
    },
    -- Telescope
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
        },
	},
    -- Treesitter 
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
	},
    {
        "ThePrimeagen/harpoon",
        dependencies = {
           "nvim-lua/plenary.nvim",
        },
    },
    -- Yes
    'eandrju/cellular-automaton.nvim',
    -- Git
    'tpope/vim-fugitive',
    -- Git related signs to the gutter and utilities for managing changes
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
            on_attach = function(bufnr)
                vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

                -- don't override the built-in and fugitive keymaps
                local gs = package.loaded.gitsigns
                vim.keymap.set({ 'n', 'v' }, ']c', function()
                    if vim.wo.diff then
                        return ']c'
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return '<Ignore>'
                end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
                vim.keymap.set({ 'n', 'v' }, '[c', function()
                    if vim.wo.diff then
                        return '[c'
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return '<Ignore>'
                end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
            end,
        },
    },
    {
        'ggandor/leap.nvim',
        config = function()
            require('leap').create_default_mappings()
            require('leap').opts.case_sensitive = true
        end,
    },
}, {})

-- require('neodev').setup()


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
-- 'tpope/vim-rhubarb',
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
