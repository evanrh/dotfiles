return {
  {
    "famiu/bufdelete.nvim",
    config = function()
      local bufdelete = require("bufdelete")

      vim.keymap.set("n", "<leader>bd", bufdelete.bufdelete, { desc = "Delete buffer" })
      vim.keymap.set("n", "<leader>bw", bufdelete.bufwipeout, { desc = "Wipe out buffer" })
      vim.keymap.set("n", "<leader>b[", function() vim.cmd(":bprevious") end, { desc = "Goto previous buffer" })
      vim.keymap.set("n", "<leader>b]", function() vim.cmd(":bnext") end, { desc = "Goto next buffer" })
    end
  }
}
