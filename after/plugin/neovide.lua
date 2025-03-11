if vim.g.neovide then 
	vim.g.neovide_opacity = 0.6
	vim.g.neovide_refresh_rate = 60
	local system = vim.loop.os_uname().sysname
	vim.o.guifont='Monaspace Neon Medium:h12'
	if system == 'Darwin' then 
		vim.g.neovide_window_blurred = true
	end
end
