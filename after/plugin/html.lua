vim.api.nvim_create_autocmd("FileType", {
  pattern = "html",
  callback = function()
		require('luasnip.loaders.from_vscode').lazy_load()
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true 
		vim.lsp.config.html = {
			capabilities = capabilities
		}
  end,
})
