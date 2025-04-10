vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- vim.keymap.set("n", "zM", require('ufo').closeAllFolds, {desc = "Close all folds"} )
-- vim.keymap.set("n", "zR", require('ufo').openAllFolds, {desc = "Open all folds"} )
-- vim.keymap.set("n", "zK", function ()
-- 		local winid = require('ufo').peekFoldedLinesUnderCursor()
-- 		if not winid then
-- 			vim.lsp.buf.hover()
-- 		end
-- 	end, {desc = "Peek fold under cursor"}
-- )
--
-- -- keymaps to note:
-- -- `zf` create a manual fold (if ":set foldmethod=manual" is set)
-- -- `zo` opens a fold
-- -- `zc` closes a fold
-- -- `za` toggles a fold
-- -- `zd` deletes a fold
-- -- `zD` deletes all folds
-- -- `zM` closes all folds
-- -- `zR` opens all folds
--
-- require('ufo').setup({
-- 	provider_selector = function(bufnr, filetype, buftype)
-- 		return {'lsp', 'indent'}
-- 	end
-- })
