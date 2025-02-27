return {
	{
	"Tsuzat/NeoSolarized.nvim", 
	lazy = false, -- load immediately
	priority = 1000, -- high priority to load first
	config = function ()
		require('NeoSolarized').setup({
			style="dark",
			transparent=true,
			terminal_colors=true,
			enable_italics=true,
			syles = {
				comment = { italic = true },
				keyword = { italic = true },
				functions = { bold = true },
				variables = {},
				string = {italic = true},
				underline=true,
				undercurl=true,
			},
			on_highlights = function (highlights, colors)
				-- if you leave the visual defaults, visual highlights are invisible
				highlights.Visual = {
					bg = '#eee8d5',
					fg = '#839496'
				}
			end,
		})

		local function bg_opacity(color)
			-- color = color or "PaperColor"
			color = color or "NeoSolarized"
			vim.cmd.colorscheme(color)
			vim.opt.background = "dark"
			vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
			vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
		end
		bg_opacity()
	end,
	}
}


