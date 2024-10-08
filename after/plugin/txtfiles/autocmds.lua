vim.api.nvim_create_autocmd('FileType', {
    pattern = {'txt','text','markdown','md'},
    callback = function ()
        vim.schedule(function ()
            vim.api.nvim_buf_set_keymap(0, "v", "<leader>go", [[:lua OpenChromeWithURL()<CR>]], { noremap=true, silent=true })
						vim.api.nvim_buf_set_keymap(0, "v", "<leader>def", [[:lua GetDefOrSyn('def')<CR>]], {noremap=true, silent=true})
						vim.api.nvim_buf_set_keymap(0, "v", "<leader>syn", [[:lua GetDefOrSyn('syn')<CR>]], {noremap=true, silent=true})
						vim.keymap.set("n", "<leader>br", [[:lua LineBreak()<CR>]], {noremap=true, silent=true})
            vim.opt_local.spell = true
						vim.api.nvim_buf_set_keymap(0, "v","<leader>wc", [[:lua WordCount()<CR>]], {noremap=true, silent=true})
        end)
    end
})

