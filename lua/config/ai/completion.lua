return {
	{"Exafunction/codeium.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp"},
	   config = function()
	   	require("codeium").setup({})
	 end},
	--  {
	--     "zbirenbaum/copilot.lua",
	--     cmd = "Copilot",
	--     event = "InsertEnter",
	-- },
	--  {
	--     "zbirenbaum/copilot-cmp",
	--     config = function()
	--         require("copilot_cmp").setup()
	--     end,
	-- },
}
