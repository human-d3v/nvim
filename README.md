# NeoVim Config
#### Dependencies:
* Python 3 - for text file handling. This is used to reach out to dictionary
  and thesaurus api's.
  * Python packages:
    * pip
    * requests
    * venv 
```bash
# for fedora linux:
## install python3
sudo dnf install python3 python3-pip &
## install venv
python3 -m pip install venv &
## create venv in txtfiles
cd ~/.config/nvim/after/plugin/txtfiles/ &
mv ./syn ./tmp &
python3 -m venv syn &
source syn/bin/activate & 
mv ./tmp/*.py ./syn & 
pip install requests sys &
rm -Rf ./tmp &
```
```bash
# for arch linux:
## install python3
sudo pacman -S python3 python3-pip &
# install venv
python3 -m pip install venv &
## create venv in txtfiles
cd ~/.config/nvim/after/plugin/txtfiles/ &
mv ./syn ./tmp &
python3 -m venv syn &
source syn/bin/activate & 
mv ./tmp/*.py ./syn/ & 
pip install requests sys &
rm -Rf ./tmp &
```
```bash
# for MacOS:
## install brew if you haven't already
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" &
## install python3 using brew
brew install python3.12 &
## install venv
brew install python3-venv &
## create venv in txtfiles
cd ~/.config/nvim/after/plugin/txtfiles/ &
mv ./syn ./tmp &
python3 -m venv syn &
source syn/bin/activate &
mv ./tmp/*.py ./syn &
pip install requests sys &
rm -Rf ./tmp &
```

_______
## Language Specific configurations
### Python
```lua
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.schedule(function()
			vim.keymap.set("n", "<leader>sql", [[:lua OpenBufferTerminalRepl('py')<CR>]] , {noremap = true, buffer = true})
			vim.keymap.set({"v","x"}, "<Bslash>d", [[:lua SendToRepl(1)<CR>]], {noremap=true, buffer=true})
			vim.keymap.set("n", "<Bslash>d", [[:lua SendToRepl(0)<CR>]], {noremap=true, buffer=true})
			vim.keymap.set("n", "<Bslash>aa", [[:lua SendToRepl(2)<CR>]], {noremap=true, buffer=true})
		end)
	end,
})
```
This is was originally designed to work as a SQL REPL when working with python
files. But It works by capturing either visual selections or the current line
and sending them to a python REPL which is opened using the `<leader>sql` key
mapping.
______
### Rust
For some quicker keymaps, I used the following commands:
```lua
vim.api.nvim_create_autocmd("FileType", {
	pattern = {"rust", "rs", "Rust"},
	callback = function ()
		vim.schedule(function ()
		vim.keymap.set("i", ">", "=>", {buffer = true})
		vim.keymap.set("i", ">>", ">", {buffer = true})
		vim.keymap.set("i", "-", "->", {buffer = true})
		vim.keymap.set("i", "--", "-", {buffer = true})
		vim.keymap.set("n", "<leader>rr", ":RustRun<CR>",{buffer = true})
		end)
	end,
})
```
This maps the '>' sign to the '=>' matching operator, the '_' to the '->' type
return operator, and `<leader>rr` to run the rust program.

Then, to configure the rust lsp, I mapped the `<leader>ca` to the code action
value.
```lua
local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set(
	"n",
	"<leader>ca",
	function ()
		vim.cmd.RustLsp('codeAction')
	end,
	{silent = true, buffer = bufnr}
)
```

______
### R Programming Language

R programming language is a dream in NeoVim. The big issue is the lintr
package. It has many issues with creating too much noise with the linting
messages. This can be easily fixed by creating a .lintr file in the
`~/` home directory.
```
linters: linters_with_defaults(
	line_length_linter(80),
	commented_code_linter = NULL,
	commas_linter = NULL,
	whitespace_linter = NULL,
	quotes_linter = quotes_linter("'"),
	object_name_linter = object_name_linter("camelCase"))
```
From there, the keymaps are pretty simple:
```lua
vim.api.nvim_create_autocmd("FileType", {
	pattern = {"r", "rnoweb","rmd"},
	callback = function ()
		vim.schedule(function ()
			vim.keymap.set("i", ">", " %>% ", {buffer = true})
			vim.keymap.set("i", ">>", ">", {buffer = true})
			vim.keymap.set("i", "in ", "%in%", {buffer = true})
			vim.keymap.set("i", "`", "```{r}\n\n```", {buffer = true})
			vim.keymap.set("i", "``", "`", {buffer = true})
		end)
	end,
})
```
This remaps the '>' operator to the ' %>% ' dplyr operator and 'in ' to the
'%in%' operator. It also adds \``` to R Markdown files.

_____
### JavaScript and TypeScript
I remapped the arrow function '=>' operator to the '>' sign:
```lua
vim.api.nvim_create_autocmd("FileType", {
	pattern = {"js", "ts", "javascript", "typescript"},
	callback = function ()
		vim.schedule(function ()
			vim.keymap.set("i", ">", "=>", {buffer = true})
			vim.keymap.set("i", ">>", ">", {buffer = true})
		end)
	end,
})
```
_____
### Stata Do Files:
I built a [dependency-free lsp server from
scratch](https://github.com/human-d3v/stata-nvim/) for Stata do files. To
launch the server, I created the following function:
```lua
local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")

local custom_attach = function (client) print("Stata LSP started"); end 


vim.cmd [[autocmd BufRead,BufNewFile *.do set filetype=stata]]

if not configs.stata then
	configs.stata = {
		default_config = {
			cmd = {
				"npx", "ts-node",
				vim.fn.expand("~/.lsp/stata/server/src/server.ts")
			},
			filetypes = {"stata"},
			root_dir = lspconfig.util.root_pattern('.git','stata'),
			settings = {}
		}
	}
end

lspconfig.stata.setup {
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	on_attach = custom_attach
}

```
This defines a Stata filetype, creates a config file and attaches it to the
filetype using lspconfig.

_____
## Other helpful configurations
### Codium AI autocompletion
Codium AI is a helpful autocompletion plugin. It only requires an api key to
use it. I created a [Codium API key](https://codium.com/api-key) and added it
my config.
```lua
{
    "Exafunction/codeium.nvim",
	dependencies = {
        "nvim-lua/plenary.nvim",
    	"hrsh7th/nvim-cmp",
    },
    config = function()
    	require("codeium").setup({
        })
    end
}
```
_____
### ChatGPT integration:
I wrote my api key to a `~/.lsp/` directory and used gpg to encrypt it. A
password prompt will appear when I open a terminal buffer to decrypt the key,
but this isn't much of a hindrance. 

In my .zshrc, it looks like this:
```bash
export OPENAI_API_KEY=$(gpg --decrypt ~/.lsp/chatgpt/credential.txt.gpg)
```
This key is added to my path and accessible to ChatGPT. 
Next, I rewrote the welcome prompt to include the keymaps:
```lua

local instructions = [[
	** Instructions **
	^^^^^^^^^^^^^^^^^^
	-> <Ctrl-Enter> -- to submit message
	-> <Ctrl-y> -- yank last answer
	-> <Ctrl-o> -- toggle settings window
	-> <Tab> -- cycle through windows
	-> <Ctrl-f> -- Cycle through modes (center, stick to right)
	-> <Ctrl-c> -- close chat window
	-> <Ctrl-u> -- scroll up chat window
	-> <Ctrl-d> -- scroll down chat window
	-> <Ctrl-k> -- yank code from last answer
	-> <Ctrl-n> -- start new session
	-> <Ctrl-d> -- draft message (without sending to server)
	-> <Ctrl-r> -- switch role (between user and assistant)
	-> <Ctrl-s> -- toggle system message window
	-> <Ctrl-i>[edit window] -- use response as input
	-> <Ctrl-d>[edit window] -- view differences between panes and use diff-mode cmds

]]

require('chatgpt').setup({
	 api_key_cmd = getKey,
	 chat = {
		welcome_message = instructions, 
	 }
})
```
This makes using the plugin much friendlier. Finally, I mapped the launch to `<leader>gpt`.
