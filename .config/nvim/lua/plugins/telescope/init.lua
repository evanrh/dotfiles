return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.6",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "Marskey/telescope-sg",
  },
  config = function()
    require("plugins.telescope.config").setup()
  end,
}
