local on_attach = function(
  _ --[[ _client ,]],
  bufnr
)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame') -- since v0.10.0 grn by default (n)
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences') -- since v0.10.0 grr by default (n)
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<A-k>', vim.lsp.buf.signature_help, 'Signature Documentation') -- since v0.10.0 CTRL-S by default (i)
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

  -- Lesser used LSP functionality
  -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  -- nmap('<leader>wl', function()
  --         print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, '[W]orkspace [L]ist Folders')

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

local servers = {
  lua_ls = {
    Lua = {
      workspace = { checkThridParty = false },
      telemetry = { enable = false },
      diagnostics = {
        globals = { 'vim', 'describe', 'it' },
      },
    },
  },

  pyright = {},

  rust_analyzer = {},

  taplo = {},

  jdtls = {},

  clangd = {},

  tsserver = {},
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require('mason-lspconfig')

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      -- filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}

vim.diagnostic.config({
  virtual_text = false,
  float = {
    style = 'minimal',
    border = 'rounded',
    header = '',
    prefix = '',
  },
})

-- :h lspconfig-root-detection
-- :h lspconfig-setup
-- :h lspconfig
-- :h mason-lspconfig.setup()
-- :h lspconfig-global-defaults
-- :h vim.diagnostic.*
-- :h lsp-handlers
-- :h lsp
-- https://github.com/neovim/nvim-lspconfig
