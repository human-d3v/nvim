vim.keymap.set("n", "<leader>ex", vim.cmd.Ex)

--move visual blocks while retaining data
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv") -- move down
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv") --move up 

vim.keymap.set('n', 'Y', "yg$")

--append from below lines to the current line without moving cursor
vim.keymap.set('n', "J", "mzJ'z")

--half page jumping without moving cursor from center of screen
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

--searching while keeping the cursor in center of screen
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

--deletes highlighted word and replaces it with value in p while placing deleted
----value in void register
--this hleps to retain value in p for future putting
vim.keymap.set('x', '<leader>p', "\"_dp")

--moves yanked values from nvim register to the system clipboard for pasting 
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
--moves copied values from system clipboard to put register
vim.keymap.set("n", "<leader>p", "\"+p")

--hardmaps esc alternative
vim.keymap.set("n", "<C-c>", "<Esc>")

--don't ever press capital Q. It's the worst place in the univserse
vim.keymap.set("n", "Q", "<nop>")

--create new tmux session for switching projects quickly
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux new tmux-sessionizer<CR>")

--lsp quick format
vim.keymap.set("n", "<leader>f", function () vim.lsp.buf.format() end)

--quickfix list navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>d", "<cmd>lprv<CR>zz")

--replacing every instance (similar to <C-F2> in vscode)
vim.keymap.set("n", "<leader>s", ":s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left>")
--take posession of a file
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", {silent = true})

--for terminal navigation (the noremap opt is important, otherwise it fails)
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], {silent = true, noremap = true})
