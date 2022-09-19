-- local lsp = require("lspconfig")
local lsp = require("lspconfig")

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- local opts = { noremap = true, silent = true }

local on_attach = function(client, bufnr)
	-- local bufopts = { noremap=true, silent=true, buffer=bufnr--[[ =0  ]]}
	local bufopts = { noremap=true, silent=true, buffer=bufnr }
	-- -v- Enable completion triggered by <c-x><c-o>
	-- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	
	vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
	vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
	vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
	vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	-- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
	-- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
end

-- cmp_nvim_lsp.update_capabilities(capabilities)

lsp['sumneko_lua'].setup{
    on_attach = on_attach,
    -- flags = lsp_flags,
}

lsp['pyright'].setup{
    on_attach = on_attach,
    -- flags = lsp_flags,
}
