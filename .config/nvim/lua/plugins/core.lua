return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  {
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup({
        library = {
          plugins = { "nvim-dap-ui" },
          types = true,
        },
      })
    end,
  },
}
