-- Setup lspconfig.
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

--Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.

require('lspconfig')['sumneko_lua'].setup {
--	capabilities = capabilities,
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
