return {
	"neovim/nvim-lspconfig",
	lazy = false,
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
    "onsails/lspkind.nvim"
	},
	config = function()
		require("plugins.lsp.config").setup()
	end
}
