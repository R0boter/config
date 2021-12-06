-- Setup lspconfig.
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Set sumneko_lua_language_server
local sumneko_root = ""
if vim.fn.has("mac") == 1 then
  sumneko_root = os.getenv("HOME").."/.config/nvim/ls/lua-language-server/bin/macOS"
elseif vim.fn.has("unix") == 1 then
  sumneko_root = os.getenv("HOME").."/.config/nvim/ls/lua-language-server/bin/Linux"
else
  print("Sorry this system is not supported!!")
end 

-- lua lsp

lspconfig['sumneko_lua'].setup {
	capabilities = capabilities,
	cmd = {sumneko_root .. "/lua-language-server"},
	settings = {
		lua = {
			runtime = {
				verion = 'LuaJIT',
				path = vim.split(package.path, ';')
			},
			diagnostics = {
				globals = {'vim'}
			},
			workspace = {
				library = {
					[vim.fn.expand('$VIMRUNTIME/lua')] = true,
					[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
				} 
			}
		}
	}
}

-- python lsp

lspconfig['pyright'].setup {
	capabilities = capabilities,
}

-- emmet lsp
lspconfig['emmet_ls'].setup {
	capabilities = capabilities,
	filetypes = {"html", "css", "vue", "javascript", "typescript"}
}

-- JS/TS lsp
lspconfig['tsserver'].setup {
	capabilities = capabilities,
	filetypes = {"html",  "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue"}
}

-- Vue2 lsp
lspconfig['vuels'].setup{
	capabilities = capabilities,
}

-- PHP lsp
lspconfig['intelephense'].setup {
	capabilities = capabilities,
}

---- CSS lsp
--
--lspconfig['cssls'].setup {
--	capabilities = capabilities,
--	filetypes = { "css", "scss", "less", "vue", "html" }
--}
--
---- HTML lsp
--
--lspconfig['html'].setup {
--	capabilities = capabilities,
--}
--
---- Json lsp
--
--lspconfig['jsonls'].setup {
--	capabilities = capabilities,
--}





























