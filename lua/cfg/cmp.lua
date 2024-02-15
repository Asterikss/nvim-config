local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup {}

local kind_icons = {
  Text = "t",
  Method = "m",
  Function = "f",
  Constructor = "constr",
  Field = "",
  Variable = "var",
  Class = "cl",
  Interface = "i",
  Module = "mod",
  Property = "ﰠ",
  Unit = "",
  Value = "",
  Enum = "en",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "file",
  Reference = "",
  Folder = "fold",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = ""
}

cmp.setup{
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    experimental = {
        ghost_text = true,
    },

    view = {
        entries = "custom" -- can be "custom", "wildmenu" or "native". selection_order = 'near_cursor'
    },

	window = {
		documentation = cmp.config.window.bordered(),
	},

    completion = {
        completeopt = "menu,menuone,noinsert"
    },

	formatting = {
		format = function(entry, vim_item)
			-- Kind icons
			-- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
			vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
			-- Source
			vim_item.menu = ({
				buffer = "[buf]",
                path = "[path]",
				nvim_lsp = "[LSP]",
				luasnip = "[lsnp]",
				-- nvim_lua = "[Lua]",
				-- latex_symbols = "[LaTeX]",
			})[entry.source.name]
			return vim_item
		end
	},

	mapping = cmp.mapping.preset.insert {
        --nice indent
      --[[ ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(), --cmp.mapping.close()
      -- ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items. clr-y
      ['<C-k>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items. clr-y
	  --["<C-y"] = cmp.config.disable, ]]

                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-p>'] = cmp.mapping.select_prev_item(),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
                ['<C-f>'] = cmp.mapping.scroll_docs(-4),
                -- ['<C-j>'] = cmp.mapping.,  -- possible danger
                ['<C-Space>'] = cmp.mapping.complete {},
                -- ['<C-k>'] = cmp.mapping.confirm {
                ['<CR>'] = cmp.mapping.confirm {
                        -- behavior = cmp.ConfirmBehavior.Replace,
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = true,
                },
                --[[
                ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                                cmp.select_next_item()
                        elseif luasnip.expand_or_locally_jumpable() then
                                luasnip.expand_or_jump()
                        else
                                fallback()
                        end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                                cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                                luasnip.jump(-1)
                        else
                                fallback()
                        end
                end, { 'i', 's' }),
                ]]

        },

        sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                -- { name = 'buffer', keyword_length = 3 },
                { name = 'buffer'},
                { name = 'path' },

        },
        -- sources = cmp.config.sources({
        --         { name = 'nvim_lsp' },
        --         { name = 'luasnip' },
        --         { name = 'path' },
        --
        -- }, {
        --                 { name = 'buffer', keyword_length = 3 },
        --         }),


}

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
