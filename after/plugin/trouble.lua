-- Setting initial keybindings
vim.keymap.set("n", "<leader>[t", function() require("trouble").toggle() end)
vim.keymap.set("n", "<leader>[tw", function() require("trouble").toggle("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>[td", function() require("trouble").toggle("document_diagnostics") end)
vim.keymap.set("n", "<leader>[tq", function() require("trouble").toggle("quickfix") end)
vim.keymap.set("n", "<leader>[tl", function() require("trouble").toggle("loclist") end)
vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)


-- close trouble
vim.keymap.set("n","[c",function() require("trouble").close() end);

-- jump to the next item, skipping the groups
vim.keymap.set("n","[n",function() require("trouble").next({skip_groups = true, jump = true}) end);

-- jump to the previous item, skipping the groups
vim.keymap.set("n", "[p",function () require("trouble").previous({skip_groups = true, jump = true}) end);

