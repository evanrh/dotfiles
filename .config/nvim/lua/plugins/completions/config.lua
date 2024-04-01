local result = {}
local cmp = require("cmp")
local luasnip = require("luasnip")

function result.setup()
  require("luasnip.loaders.from_vscode").lazy_load()
  cmp.setup({
    ghost_text = { enabled = true },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end
    },
    mapping = {
      ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = "path" },
      { name = "nvim_lsp", keyword_length = 1 },
      { name = "luasnip", keyword_length = 2},
      { name = "buffer", keyword_length = 3},
    },
    window = {
      documentation = cmp.config.window.bordered()
    }
  })

end

return result
