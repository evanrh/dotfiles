return {
  "startup-nvim/startup.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local startup = require("startup")

    startup.create_mappings({
      ["<leader>fs"] = "<cmd>Telescope session-lens<CR>"
    })

    startup.setup()
  end
}
