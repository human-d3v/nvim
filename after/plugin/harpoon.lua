local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set('n', '<leader>a', mark.add_file)

--harpoon menu appears when you type ctrl + e
vim.keymap.set('n', '<C-e>', ui.toggle_quick_menu)
--with the menu onscreen, map functions for navigation
	vim.keymap.set('n', '<C-h>',function() ui.nav_file(1) end) --h for first
	vim.keymap.set('n', '<C-g>',function() ui.nav_file(2) end) --g for second
	vim.keymap.set('n', '<C-m>',function() ui.nav_file(3) end) --m for third
	vim.keymap.set('n', '<C-s>',function() ui.nav_file(4) end) --s for fourth
