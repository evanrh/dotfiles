return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  {
    "folke/lazydev.nvim",
    config = function()
      require("lazydev").setup()
    end,
  },
}
