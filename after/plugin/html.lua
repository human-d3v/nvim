vim.api.nvim_create_autocmd("FileType", {
  pattern = "html",
  callback = function()
		require('luasnip.loaders.from_vscode').lazy_load()
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true 
		require('lspconfig').html.setup{
			capabilities = capabilities
		}
  end,
})
