local cmp = require('cmp')
local luasnip = require('luasnip')
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

local kind_icons = {
  Text = 't',
  Method = 'm',
  Function = 'f',
  Constructor = 'constr',
  Field = '',
  Variable = 'var',
  Class = 'cl',
  Interface = 'i',
  Module = 'mod',
  Property = 'ﰠ',
  Unit = '',
  Value = '',
  Enum = 'en',
  Keyword = '',
  Snippet = '',
  Color = '',
  File = 'file',
  Reference = '',
  Folder = 'fold',
  EnumMember = '',
  Constant = '',
  Struct = '',
  Event = '',
  Operator = '',
  TypeParameter = '',
}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
      -- vim.snippet.expand(args.body) -- Neovim v0.10+
    end,
  },

  experimental = {
    ghost_text = true,
  },

  view = {
    entries = 'custom', -- can be "custom", "wildmenu" or "native". selection_order = 'near_cursor'
  },

  window = {
    documentation = cmp.config.window.bordered(),
  },

  completion = {
    completeopt = 'menu,menuone,noinsert', -- noselect
  },

  formatting = {
    format = function(entry, vim_item)
      -- Kind icons
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
      -- Source
      vim_item.menu = ({
        buffer = '[buf]',
        path = '[path]',
        nvim_lsp = '[LSP]',
        luasnip = '[lsnp]',
        otter = '[🦦]',
        -- nvim_lua = "[Lua]",
        -- latex_symbols = "[LaTeX]",
      })[entry.source.name]
      return vim_item
    end,
  },

  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<C-y>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert, -- Replace
      select = true,
    },
    -- ['<C-e>'] = cmp.mapping.abort(), --cmp.mapping.close()
  },

  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' }, -- keyword_length = 3, max_item_count = 3 },
    { name = 'path' },
    { name = 'treesitter', max_item_count = 3 }, -- keyword_length = 5 },
    { name = 'otter' },
  },
}

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

cmp_autopairs.get_rules('"')[1].not_filetypes = { 'typescript', 'lua' }
cmp_autopairs.get_rules("'")[1].not_filetypes = { 'typescript', 'lua' }
-- require("nvim-autopairs").get_rules('"')[1].key_map = '"'
-- require("nvim-autopairs").get_rules('"')[1].start_pair = "'"
-- require("nvim-autopairs").get_rules('"')[1].end_pair = "'"
-- lua print(vim.inspect(require('nvim-autopairs').get_rules('"')))
