vim.api.nvim_create_autocmd("FileType", {
	pattern = {"r", "rnoweb","rmd"},
	callback = function ()
		vim.schedule(function ()
			vim.keymap.set('t','<leader>mv', ":lua ResizeAndMove(80)<CR>", {buffer = true})
			vim.keymap.set("i", "<C-.>", " %>% ", {buffer = true})
			vim.keymap.set("i", "<C-->", "<Plug>RInsertAssign", {buffer = true, silent = true}) -- reassign keymap for assignment
			require('cmp').setup({sources = {
				{ name = "cmp_r" },
				{ name = "codeium" }, 
				{ name = "luasnip" },
				{ name = "nvim_lsp_signature_help" },
				{ name = "buffer" },
			}})
			require('cmp_r').setup({})
		end)
	end
})
