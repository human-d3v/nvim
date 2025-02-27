-- todo
-- lang {'rust', 'python','typescript','r'}

local harpoon = {
	{key = '<leader>a',mode = 'normal', action = 'add current file to end of UI list'}, 
	{key = 'Ctrl + e', mode = 'normal', action = 'Open UI list'}, 
	{key = 'Ctrl + h', mode = 'normal', action = 'Open first UI list item'}, 
	{key = 'Ctrl + t', mode = 'normal', action = 'Open second UI list item'}, 
	{key = 'Ctrl + n', mode = 'normal', action = 'Open third UI list item'}, {key = 'Ctrl + s', mode = 'normal', action = 'Open fourth UI list item'}, 
	{key = 'Ctrl + Shift + P', mode = 'normal' ,action = 'Open previous UI list item'},
	{key = 'Ctrl + Shift + N', mode = 'normal' ,action = 'Open previous UI list item'},
}

local git = {
	{key = '<leader> + gs', mode = 'normal', action = 'Opens git fugitive buffer'},
}

local undotree = {
	{key = '<leader> + u', mode = 'normal', action = 'Opens undotree buffer'},
}

local settings = {
	{key = 'Shift + J', mode = 'visual', action = 'Move visual line down'},
	{key = 'Shift + K', mode = 'visual', action = 'Move visual line up'},
	{key = 'Shift + J', mode = 'normal', action = 'Append next lines to current line'},
	{key = 'Ctrl + D', mode = 'normal', action = 'Half-page jumping down without moving cursor from center'},
	{key = 'Ctrl + U', mode = 'normal', action = 'Half-page jumping up without moving cursor from center'},
	{key = '<leader> + p', mode = 'visual', action = 'deletes highlighted word and replaces it with value in p while placing deleted value in void register'},
	{key = '<leader> + y', mode = 'normal', action = 'Moves yanked values from register to the system clipboard'},
	{key = '<leader> + y', mode = 'visual', action = 'Moves yanked values from register to the system clipboard'},
	{key = '<leader> + p', mode = 'normal', action = 'Pastes copied values from system clipboard'},
	{key = 'Ctrl + c', mode = 'insert/visual', action = 'Exits visual or insert mode to normal mode'},
	{key = 'Ctrl + f', mode = 'normal', action = 'Creates new tmux session'},
	{key = '<leader> + f', mode = 'normal', action = 'LSP format'},
	{key = 'Ctrl + k', mode = 'normal', action = 'Next quickfix list item'},
	{key = 'Ctrl + j', mode = 'normal', action = 'Previous quickfix list item'},
	{key = '<leader> + k', mode = 'normal', action = 'Next location list item'},
	{key = '<leader> + d', mode = 'normal', action = 'Previous location list item'},
	{key = '<leader> + x', mode = 'normal', action = 'Run chmod +x on current file'},
	{key = '<leader> + <leader> + term', mode = 'normal', action = 'Open terminal in new split'},
}

local telescope = {
	{key = '<leader> + ff', mode = 'normal', action = 'Find files in current directory'},
	{key = '<leader> + ps', mode = 'normal', action = 'Grep in current directory'},
	{key = 'Ctrl + p', mode = 'normal', action = 'Search git files'},
}

local lang = {
	rust = {
		{key = '<leader> + rr', mode = 'normal', action = 'Rust run'},
		{key = '<leader> + ca', mode = 'normal', action = 'Rust code action'}
	},
	python = {
		{key = '<leader><leader> + py', mode = 'normal', action = 'Open Python REPL'},
		{key = '\\ + d', mode = 'normal', action = 'Send current line to REPL'},
		{key = '\\ + d', mode = 'visual', action = 'Send current line to REPL'},
		{key = '\\ + aa', mode = 'visual', action = 'Send current file up to and including current line to REPL'},
	},
	r = {
		{key = '\\ + rf', mode = 'normal', action = 'Open R Terminal in new split'},
		{key = '\\ + ro', mode = 'normal', action = 'Open R .GlobalEnv in new split'},
		{key = '\\ + rm', mode = 'normal', action = 'Clear memory in .GlobalEnv and Terminal'},
		{key = '\\ + rq', mode = 'normal', action = 'Quit R .GlobalEnv and R Terminal'},
		{key = '\\ + d', mode = 'normal', action = 'Send current line to R Terminal'},
		{key = '\\ + aa', mode = 'normal', action = 'Source current file in R Terminal'},
	},
}

local main = {
	harpoon = harpoon,
	git = git,
	undotree = undotree,
	settings = settings,
	telescope = telescope,
}
