-- local home = vim.fn.expand('$HOME')
-- local cmd = "gpg --decrypt /.lsp/chatgpt/credential.txt.gpg"
--
-- vim.keymap.set("n", "<leader><leader>test",function() print(cmd) end,{noremap = true, buffer = true})

require('chatgpt').setup({
  api_key_cmd = "gpg --decrypt /Users/bryar.topham/.lsp/chatgpt/credential.txt.gpg"
})

