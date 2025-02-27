local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "

local plugins = {
	{'nvim-lua/plenary.nvim'},
	{"neovim/nvim-lspconfig"},
	-- treesitter, harpoon, trouble, fugitive
	require('config.nav'),
	-- colors
	require("config.colors"),
	--lsp configuration, diagnostics
	require('config.lsp'),
	--language specific configs
	require('config.lang'),
	--ai stuff
	require('config.ai'),
}


require("lazy").setup(plugins, {})

