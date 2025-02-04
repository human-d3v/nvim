if vim.g.neovide then 
	vim.g.neovide_transparency = 0.6
	vim.g.neovide_refresh_rate = 60
	local system = vim.loop.os_uname().sysname
	if system == 'Darwin' then 
		vim.o.guifont='Monaspace Neon Medium:h12'
		vim.g.neovide_window_blurred = true
	end
end
