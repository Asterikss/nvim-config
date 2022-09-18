local cmp = require("cmp")
-- local lspkind = require('lspkind') -- add this plgin to customize kind_icons

require("luasnip")

require("luasnip/loaders/from_vscode").lazy_load()

local kind_icons = {
  Text = "t",
  Method = "m",
  Function = "f",
  Constructor = "contr",
  Field = "",
  Variable = "v",
  Class = "c",
  Interface = "i",
  Module = "mod",
  Property = "ﰠ",
  Unit = "",
  Value = "",
  Enum = "en",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "fil",
  Reference = "",
  Folder = "fol",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = ""
}

cmp.setup{
	mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(), --cmp.mapping.close()
      -- ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items. clr-y
      ['<C-k>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items. clr-y
	  --["<C-y"] = cmp.config.disable,
    }),

	sources = cmp.config.sources({
      -- { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'path' },
	  
    }, {
      { name = 'buffer', keyword_length = 4 },
    }),

    snippet = {
      expand = function(args)
		  require('luasnip').lsp_expand(args.body)
		end,
	},		

	experimental = {
		ghost_text = true,
	},

	--[[ view = {                                                        
		entries = {name = 'custom', selection_order = 'near_cursor' } 
	},                                                                ]]

	view = {            
		entries = "custom" -- can be "custom", "wildmenu" or "native"
	}, 

	window = {
		documentation = cmp.config.window.bordered(),
	},

	formatting = {
		format = function(entry, vim_item)
			-- Kind icons
			-- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
			vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
			-- Source
			vim_item.menu = ({
				buffer = "[buf]",
				nvim_lsp = "[LSP]",
				luasnip = "[s]",
				-- nvim_lua = "[Lua]",
				-- latex_symbols = "[LaTeX]",
			})[entry.source.name]
			return vim_item
		end
	},

}
