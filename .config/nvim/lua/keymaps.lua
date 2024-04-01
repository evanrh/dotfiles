local result = {}

function result.setup()

  vim.keymap.set("n", "<Esc>", function() vim.opt.hlsearch = not vim.opt.hlsearch:get() end, { buffer = true })
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "
end

return result
