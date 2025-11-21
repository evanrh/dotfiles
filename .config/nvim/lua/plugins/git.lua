return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end
  },
  {
    "f-person/git-blame.nvim",
    config = function()
      require("gitblame").setup({
        enabled = true,
      })
    end
  },
  {
    "tpope/vim-fugitive",
    config = function()
    end
  }
}
