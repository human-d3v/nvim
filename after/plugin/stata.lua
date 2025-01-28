vim.api.nvim_create_autocmd('FileType', {
  pattern = 'stata',
  callback = function()
		local stata = require('stata-nvim')
    stata.setup({dev = false})
  end,
})

