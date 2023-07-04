local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
-- ^ saw that one line somewhere. No idea if its needed
--
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local capabilities_setup = cmp_nvim_lsp.default_capabilities(capabilities)
-- not sure which one is better and what is the difference. Both work.
-- I will investigate it later. For now using kinda both. Does not change
-- startup time really

local lsp = require("lspconfig")

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

-- https://github.com/neovim/nvim-lspconfig#Suggested-configuration

-- might not do that on attach later
local on_attach = function(_--[[ _client ,]], bufnr)
	local bufopts = { noremap=true, silent=true, buffer=bufnr }
	-- -v- Enable completion triggered by <c-x><c-o>
	-- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- -v- see h: deprecated
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gt', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)

	vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, bufopts)
	vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
	vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
	vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, bufopts)

	-- vim.keymap.set('n', '<space>z', vim.diagnostic.get(bufnr, {severity = vim.diagnostic.severity.INFO}).setloclist, bufopts)
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	-- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
	-- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	-- https://github.com/neovim/nvim-lspconfig#Suggested-configuration

	-- an example

		  --[[ local function organize_imports()
			local params = {
			  command = 'pyright.organizeimports',
			  arguments = { vim.uri_from_bufnr(0) },
			}
			vim.lsp.buf.execute_command(params)
		  end ]]

    --[[ if client.name == "pyright" then
      vim.api.nvim_create_user_command("PyrightOrganizeImports", organize_imports, {desc = 'Organize Imports'})
    end ]]

	--
end

-- :h lspconfig-setup
-- :h lspconfig
-- :h mason-lspconfig.setup()
-- :h lspconfig-global-defaults
-- :h vim.diagnostic.*

lsp['lua_ls'].setup{
	capabilities = capabilities_setup,
    on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			-- this does not work here (For future reference)
			--[[ float = {
				style = "minimal",
				border = "rounded",
				header = "",
				prefix = "",
			}, ]]
		}
	},

	-- I moved this setup to the bottom of the file (Should be global now)
	-- Disabling virtual_text works, but I cannot change float specifications
	-- Works in the vim.diagnostic.config though (down there)

	-- handlers = {

		--[[ ["textDocument/publishDiagnostics"] = vim.lsp.with(
		vim.lsp.diagnostic.on_publish_diagnostics, {
		-- vim.lsp.diagnostic.config, { --  < this does not work
			virtual_text = false,
			-- -v- this does not work. Probably need to be in a different handler
			float = {
				style = "minimal",
				border = "rounded",
				header = "",
				prefix = "",
			}
		}), ]]

		-- this does not work. I am not sure what to put inside the [""]
		--[[ ["window/showMessage"] = vim.lsp.with(
		vim.diagnostic.open_float, {
			float = {
				style = "minimal",
				border = "rounded",
				header = "",
				prefix = "",
			}
		}), ]]

	-- }

}

lsp['pyright'].setup{
    on_attach = on_attach,
	capabilities = capabilities_setup,
    -- flags = lsp_flags,
}

-- :h lspconfig-root-detection
lsp['jdtls'].setup{
    on_attach = on_attach,
	-- root_dir = util.root_pattern('.classpath'),
							root_dir = lsp.util.root_pattern('.classpath', '.git'),
	--[[ root_dir =  {

	} ]]
	-- does it work like that?
	-- capabilities = capabilities,
	capabilities = capabilities_setup,
}

lsp['rust_analyzer'].setup{
    on_attach = on_attach,
	capabilities = capabilities_setup,
}

-- for TOML files
lsp['taplo'].setup{
    on_attach = on_attach,
	capabilities = capabilities_setup,
}

-- It didn't override previous vim.diagnostic configs in my testing. Might do that though. .setup{} does that
vim.diagnostic.config({
  virtual_text = false,
  float = {
		style = "minimal",
		border = "rounded",
		header = "",
		prefix = "",
	},
})

-- does not work (for future reference)
--[[ vim.diagnostic.open_float.config({
	float = {
		style = "minimal",
		border = "rounded",
		header = "",
		prefix = "",
	}
}) ]]


