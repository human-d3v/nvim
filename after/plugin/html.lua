vim.api.nvim_create_autocmd("FileType", {
  pattern = "html",
  callback = function()
		require('luasnip.loaders.from_vscode').lazy_load()
  end,
})
