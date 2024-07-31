return {
	"neovim/nvim-lspconfig",
	lazy = false,
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
    "onsails/lspkind.nvim",
    "kosayoda/nvim-lightbulb",
    "aznhe21/actions-preview.nvim",
    "b0o/SchemaStore.nvim",
	},
	config = function()
		require("plugins.lsp.config").setup()
	end
}
