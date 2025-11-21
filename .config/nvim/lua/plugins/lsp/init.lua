return {
  "neovim/nvim-lspconfig",
  event = "VeryLazy",
  dependencies = {
    "williamboman/mason.nvim",
    "onsails/lspkind.nvim",
    "aznhe21/actions-preview.nvim",
    "b0o/SchemaStore.nvim",
    "pmizio/typescript-tools.nvim"
  },
  config = function()
    require("plugins.lsp.config").setup()
  end,
}
