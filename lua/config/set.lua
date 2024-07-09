--this file contains all of the various 'set' commands that init on startup

--line numbering
vim.opt.nu = true
vim.opt.relativenumber = true

--tab spaces
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.expandtab = true

--hand off undoing to undotree plugin and don't keep a swapfile
vim.opt.swapfile = false
vim.opt.backup = false
vim.undodir = os.getenv("HOME") .. "/.vim.undodir"
vim.opt.undofile = true

--set incremental search. THis helps immensly with tricky searches
vim.opt.hlsearch = false
vim.opt.incsearch = true

--I like good colors
vim.opt.termguicolors = true

--set scrolling so you don't reach the end of the file
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

--fast update time
vim.opt.updatetime = 50

--color column
vim.opt.colorcolumn = "80"

--a better place to move the leader reamap
vim.g.mapleader = " "

--filetype trigger
vim.opt.filetype='on'

--stata filetype handler
vim.cmd [[
	autocmd BufRead,BufNewFile *.do set filetype=stata
	autocmd BufRead,BufNewFile *.ado set filetype=stata
	autocmd BufRead,BufNewFile *.dct set filetype=stata
	autocmd BufRead,BufNewFile *.ipynb set filetype=python
]]
