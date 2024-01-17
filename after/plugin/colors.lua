function bgOpacity(color)
	--color = color or "PaperColor"
	-- color = color or 'doom-molokai' 
	color = "no-clown-fiesta"
	vim.cmd.colorscheme(color)
	vim.opt.background = "dark"
	vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
	vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
end

require("no-clown-fiesta").setup({
  transparent = true, -- Enable this to disable the bg color
  styles = {
    -- You can set any of the style values specified for `:h nvim_set_hl`
    comments = {},
    keywords = {},
    functions = {},
    variables = {},
    type = { bold = true },
    lsp = { underline = true }
  },
})

bgOpacity()
