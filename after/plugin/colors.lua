-- local okay_status, NeoSolarized = pcall(require, "NeoSolarized")
-- if not okay_status then
--   return
-- end
--
-- NeoSolarized.setup({
-- 	style="dark",
-- 	transparent=true,
-- 	terminal_colors=true,
-- 	enable_italics=true,
-- 	syles = {
-- 		comment = { italic = true },
-- 		keyword = { italic = true },
-- 		functions = { bold = true },
-- 		variables = {},
-- 		string = {italic = true},
-- 		underline=true,
-- 		undercurl=true,
-- 	},
-- 	on_highlights = function (highlights, colors)
-- 		-- if you leave the visual defaults, visual highlights are invisible
-- 		highlights.Visual = {
-- 			bg = '#eee8d5',
-- 			fg = '#839496'
-- 		}
-- 	end,
-- })

require('ayu').setup({
	-- mirage = true,
	terminal = true, 
	overrides = {
		Normal = { bg = "none" },
		NormalFloat = { bg = "none" },
		-- Folded = { bg = "none" },
		FoldColumn = { bg = "none" },
		CursorLine = { bg = "none" },
		VertSplit = { bg = "none" },
		SignColumn = { bg = "none" },
		Visual = { -- defaults too dark on transparent terminal
			bg = '#eee8d5',
      fg = '#839496'
		},
		LineNr = { fg = '#839496' }, -- line number col too dark
	}
})

local function bg_opacity(color)
	-- color = color or "PaperColor"
	-- color = color or "NeoSolarized"
	color = color or "ayu"
	vim.cmd.colorscheme(color)
	vim.opt.background = "dark"
	vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
	vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
end



bg_opacity()
