function bgOpacity(color)
	--color = color or "PaperColor"
	color = color or 'doom-palenight' 
	vim.cmd.colorscheme(color)
	vim.opt.background = "dark"
	vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
	vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
end

bgOpacity()
