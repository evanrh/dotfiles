local result = {}
local cmp = require("cmp")
local luasnip = require("luasnip")

function result.setup()
  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end
    },
    sources = {
      { name = "nvim_lsp" }
    },
  })
end

return result
