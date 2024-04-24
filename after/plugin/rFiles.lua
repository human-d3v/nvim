function ResizeAndMove(px)
	vim.cmd('wincmd J')
	vim.cmd('res -' .. px)
end

-- local function insertTextAtCursor(text)
--     local row, col = unpack(vim.api.nvim_win_get_cursor(0))
--     vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, {text})
-- end
--
-- function R_in_Pipe()
-- 	local line = vim.api.nvim_get_current_line()
-- 	if string.sub(line,1,1) == "#" then
-- 		insertTextAtCursor("in ")
-- 	else
-- 		insertTextAtCursor("%in% ")
-- 	end
-- end

vim.api.nvim_create_autocmd("FileType", {
	pattern = {"r", "rnoweb","rmd"},
	callback = function ()
		vim.schedule(function ()
			vim.keymap.set('t','<leader>mv', ":lua ResizeAndMove(80)<CR>", {buffer = true})
			vim.keymap.set("i", ">", " %>% ", {buffer = true})
			vim.keymap.set("i", ">>", ">", {buffer = true})
			vim.keymap.set("i", "`", "```{r}\n\n```", {buffer = true})
			vim.keymap.set("i", "``", "`", {buffer = true})
			-- vim.keymap.set("i", "in ", R_in_Pipe(), {buffer = true})
		end)
	end,
})


-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = {"r", "rnoweb", "rmd"},
--     callback = function ()
--         vim.schedule(function ()
--             vim.keymap.buf("i", ">", " %>% ")
--             vim.keymap.buf("i", ">>", ">")
--             vim.keymap.buf("i", "in ", R_in_Pipe())
--             vim.keymap.buf("i", "`", "```{r}\n\n```")
--             vim.keymap.buf("i", "``", "`")
--         end)
--     end,
-- })

-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = {"r", "rnoweb", "rmd"},
--     callback = function ()
--         vim.schedule(function ()
--             local bufnr = vim.api.nvim_get_current_buf()
--             local opts = { noremap = true, silent = true }
--             vim.api.nvim_buf_set_keymap(bufnr, "i", ">", " %>% ", opts)
--             vim.api.nvim_buf_set_keymap(bufnr, "i", ">>", ">", opts)
--             vim.api.nvim_buf_set_keymap(bufnr, "i", "in ", R_in_Pipe(), opts)
--             vim.api.nvim_buf_set_keymap(bufnr, "i", "`", "```{r}\n\n```", opts)
--             vim.api.nvim_buf_set_keymap(bufnr, "i", "``", "`", opts)
--         end)
--     end,
-- })
--
