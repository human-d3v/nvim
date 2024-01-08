vim.api.nvim_create_autocmd('FileType', {
    pattern = {'txt','text'},
    callback = function ()
        vim.schedule(function ()
            vim.api.nvim_buf_set_keymap(0, "v", "<leader>go", [[:lua OpenChromeWithURL()<CR>]], { noremap=true, silent=true })
						vim.api.nvim_buf_set_keymap(0, "v", "<leader>df", [[:lua GetDef()<CR>]], {noremap=true, silent=true})
						vim.api.nvim_buf_set_keymap(0, "v", "<leader>syn", [[:lua GetSyns()<CR>]], {noremap=true, silent=true})
						vim.keymap.set("n", "<leader>br", [[:lua LineBreak()<CR>]], {noremap=true, silent=true})
            vim.opt_local.spell = true
        end)
    end
})

