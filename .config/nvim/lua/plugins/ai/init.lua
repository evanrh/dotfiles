return {
  "folke/sidekick.nvim",
  config = function()
    require("sidekick").setup()
  end,
  opts = {
    nes = { enabled = false }
  },
  dependencies = {
    "zbirenbaum/copilot.lua"
  }
}
