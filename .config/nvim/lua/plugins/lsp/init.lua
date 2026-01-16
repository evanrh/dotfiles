return {
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "onsails/lspkind.nvim",
      "pmizio/typescript-tools.nvim"
    },
    config = function()
      require("plugins.lsp.config").setup()
    end,
  },
  { "b0o/SchemaStore.nvim" }
}
