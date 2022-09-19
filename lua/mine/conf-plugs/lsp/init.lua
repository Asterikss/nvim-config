local lsp = require("lspconfig")

-- See `:help vim.diagnostic.*` for documentation on any of the below functions

-- :h lsp-handlers		for some reason -v- does not work. I put it in the setup directly
--[[ vim.lsp.start_client {
	-- ..., Other configuration omitted.
	handlers = {
		["textDocument/publishDiagnostics"] = vim.lsp.with(
		vim.lsp.diagnostic.on_publish_diagnostics, {
			-- Disable virtual_text
			virtual_text = false,
		})
	},
} ]]
-- put it in handler = handler

-- might not do that on on attach later
local on_attach = function(_,--[[ _client ,]] bufnr)
	local bufopts = { noremap=true, silent=true, buffer=bufnr }
	-- -v- Enable completion triggered by <c-x><c-o>
	-- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, bufopts)
	-- -v- see h: deprecated
	vim.keymap.set('n', 'gl' , '<cmd>lua vim.diagnostic.open_float()<CR>', bufopts)
	-- vim.keymap.set('n', 'gl' , '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>', bufopts)
	vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
	vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
	vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, bufopts)
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	-- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
	-- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

end
-- :h lspconfig-setup
-- :h lspconfig

local lsp_flags = {
	-- virtual_text = false
	float = {
		style = "minimal",
		header = "",
		prefix = ""
	},
}

lsp['sumneko_lua'].setup{
    on_attach = on_attach,

	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		}
	},

	lsp_flags = lsp_flags,

	handlers = {
		["textDocument/publishDiagnostics"] = vim.lsp.with(
		vim.lsp.diagnostic.on_publish_diagnostics, {
			virtual_text = false
		}),

		-- float = {
		-- 	style = "minimal",
		-- 	header = "",
		-- 	prefix = ""
		-- },
	}

}

lsp['pyright'].setup{
    on_attach = on_attach,
    -- flags = lsp_flags,
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp = require("cmp_nvim_lsp")
cmp_nvim_lsp.update_capabilities(capabilities)

