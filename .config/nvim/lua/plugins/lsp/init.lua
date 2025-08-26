return {
  "neovim/nvim-lspconfig",
  event = "VeryLazy",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "onsails/lspkind.nvim",
    "aznhe21/actions-preview.nvim",
    "b0o/SchemaStore.nvim",
  },
  config = function()
    require("plugins.lsp.config").setup()
  end,
}
