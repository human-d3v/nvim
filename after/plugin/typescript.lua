local lspconfig = require('lspconfig')

lspconfig.tsserver.setup({
	init_options = {
		preferences = {
			includeInlayParameterNameHints = 'all',
			includeInlayParameterNameHintsWhenArgumentMatchesName = true,
			includeInlayFunctionParameterTypeHints = true,
			includeInlayVariableTypeHints = true, 
			includeInlayPropertyDeclarationTypeHints = true, 
			includeInlayFunctionLikeReturnTypeHints = true, 
			includeInlayEnumMemberValueHints = true,
			importModuleSpecifierPreference = 'non-relative',
		}
	},
})

