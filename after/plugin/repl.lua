local toggleterm = require('toggleterm')
local midnight = require("midnight.colors")

toggleterm.setup({
	shade_terminals = false,
	highlights = {
		Normal = {
			guibg = midnight.components.none
		}
	}
})


function Print_Term_Info()
	local term_info = require("toggleterm.terminal").Terminal
	for k, v in pairs(term_info) do
		print(k,v)
	end
end

local function terminal_linker_buf(term_id)
	local toggleterm = require("toggleterm.terminal").Terminal
	if not toggleterm.is_open() then
		print("No terminal found...")
		return
	end

	-- open terminal in bg to ensure buffer is initialized
	-- tt_term.open(0, false)

	local term_buf = tt_term.bufnr
	if not term_buf then
		print("Terminal buffer not found....")
		return
	end

	-- Create floating window
  local win_width = vim.api.nvim_win_get_width(0)
  local float_width = math.ceil(win_width * 0.4)
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row = cursor[1] + 1
  local col = cursor[2] + 1

  local float_buf = vim.api.nvim_create_buf(false, true)
  local float_win = vim.api.nvim_open_win(float_buf, false, {
    relative = "editor",
    width = float_width,
    height = 1,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded",
  })

  -- Link the terminal buffer to the floating window
  vim.api.nvim_win_set_buf(float_win, term_buf)

  vim.api.nvim_buf_set_keymap(term_buf, "n", "<C-c>", "<C-\\><C-n>:q!<CR>", { noremap = true, silent = true })
end

vim.keymap.set("n", "<Bslash>t", function ()
	local win = vim.api.nvim_get_current_win()
	toggleterm.toggle(1) -- assuming terminal ID 1
	vim.schedule(function()
		vim.api.nvim_set_current_win(win)
	end)
end, {buffer = true, silent = true})

vim.keymap.set("n", "<leader>t", function()
	terminal_linker_buf()
end, {})

vim.api.nvim_create_autocmd("FileType",{
	pattern = {
		"python",
		"stata"
	},
	callback = function ()
		vim.schedule(function ()
			local opts = {buffer = true, silent = true}
			vim.keymap.set("n", "<Bslash>d", function ()
				toggleterm.send_lines_to_terminal("single_line", false, {})
			end, opts)
			vim.keymap.set("v", "<Bslash>d", function ()
				toggleterm.send_lines_to_terminal("visual_lines", false, {})
			end, opts)
			vim.keymap.set("n", "<Bslash>t", function ()
				local win = vim.api.nvim_get_current_win()
				toggleterm.toggle(1)
				vim.schedule(function ()
					vim.api.nvim_set_current_win(win)
				end)
			end, opts)
		end)
	end
})
