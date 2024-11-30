vim.g.mapleader = ' '
vim.g.maplocalleader = ','

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
    "savq/melange", -- enabled = false
    "folke/tokyonight.nvim", -- enabled = false
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
        },
    },
    {
        "folke/neodev.nvim",  -- require('neodev').setup()
        enabled = false,
        opts = { -- https://discourse.nixos.org/t/minimal-but-nice-neovim-configuration/45523/8
            library = {
                runtime = false, -- runtime path
                types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
                plugins = false, -- installed opt or start plugins in packpath
            },
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
            -- "hrsh7th/cmp-cmdline",

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
    {
        'eandrju/cellular-automaton.nvim',
        cmd = "Cell",
    },
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
        keys = { "s" },
        config = function()
            require('leap').create_default_mappings()
            require('leap').opts.case_sensitive = true
        end,
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    },
    "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
    {
        'shortcuts/no-neck-pain.nvim',
        version = '*',
        opts = {
            width = 130,
            buffers = {
                right = {
                    enabled = false,
                },
            },
        },
    },
    {
        'quarto-dev/quarto-nvim',
        ft = { 'quarto' },
        dev = false,
        opts = {
            lspFeatures = {
                languages = { 'python' },
            },
            codeRunner = {
                enabled = false,
                default_method = nil, -- 'molten' or 'slime'
                -- ft_runners = {}, -- filetype to runner, ie. `{ python = "molten" }`.
                -- Takes precedence over `default_method`
                -- never_run = { "yaml" }, -- filetypes which are never sent to a code runner
            },
        },
        dependencies = {
            -- for language features in code cells
            {
                'jmbuhr/otter.nvim',
                dev = false,
                dependencies = {
                    {
                        'neovim/nvim-lspconfig',
                        'nvim-treesitter/nvim-treesitter',
                    },
                },
                opts = {},
            },
        },
    },
    {
        'ray-x/lsp_signature.nvim',
        enabled = false,
        event = 'VeryLazy',
        opts = {},
        config = function(_, opts) require'lsp_signature'.setup(opts) end
    },
    {
        'stevearc/oil.nvim',
        opts = {
            keymaps = {
                ['<C-h>'] = false,
            },
            view_options = {
                show_hidden = true,
            },
        },
        dependencies = { { "echasnovski/mini.icons", opts = {} } }, -- { "nvim-tree/nvim-web-devicons" }
    },
    {
        dir = '/home/lono/cod/projects/kiss-sessions.nvim',
        name = 'kiss-sessions-L',
        opts = {},
    },
    'sindrets/diffview.nvim',
    {
        "lervag/vimtex",
        lazy = false,
        init = function()
            vim.g.vimtex_view_method = "zathura"
        end
    },
}, {})
