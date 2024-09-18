local result = {}
local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

function result.setup()
  require("luasnip.loaders.from_vscode").lazy_load()
  cmp.setup({
    enabled = function()
      local bufnr = vim.api.nvim_get_current_buf()
      return vim.bo[bufnr].buftype ~= "prompt"
        or require("cmp_dap").is_dap_buffer()
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

  -- Setup completions for debugger views
  cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
    sources = {
      name = "dap",
    },
  })
end

return result
