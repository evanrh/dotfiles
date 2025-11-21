local result = {}
local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

function result.setup()
  require("luasnip.loaders.from_vscode").lazy_load()
  luasnip.filetype_extend("typescript", { "angular" })
  luasnip.filetype_extend("html", { "angular" })

  cmp.setup({
    enabled = function()
      local bufnr = vim.api.nvim_get_current_buf()
      return vim.bo[bufnr].buftype ~= "prompt"
    end,
    ghost_text = { enabled = true },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = {
      ["<Tab>"] = cmp.mapping.select_next_item({
        behavior = cmp.SelectBehavior.Insert,
      }),
      ["<S-Tab>"] = cmp.mapping.select_prev_item({
        behavior = cmp.SelectBehavior.Insert,
      }),
      ["<Down>"] = cmp.mapping.select_next_item({
        behavior = cmp.SelectBehavior.Insert,
      }),
      ["<Up>"] = cmp.mapping.select_prev_item({
        behavior = cmp.SelectBehavior.Insert,
      }),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = "copilot", keyword_length = 1 },
      { name = "path" },
      { name = "nvim_lsp", keyword_length = 1 },
      { name = "luasnip", keyword_length = 2 },
      { name = "buffer", keyword_length = 3 },
    },
    window = {
      documentation = cmp.config.window.bordered(),
    },
    formatting = {
      format = lspkind.cmp_format({
        mode = "symbol_text",
        maxwidth = 50,
        ellipsis_char = "...",
        show_labelDetails = true,
      }),
    },
  })

  cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" }
    }
  });

  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
      {
        { name = "path" }
      },
      {
        {
          name = "cmdline",
          option = {
            ignore_cmds = { "Man", "!" },
          }
        }
      }
    )
  });
end

return result
