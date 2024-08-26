return {
  {
    "stevearc/conform.nvim",
    config = function()
      local conform = require("conform")
      local jsFormatOptions = function()
        return { "prettierd", "prettier", stop_after_first = true }
      end
      conform.setup({
        formatters_by_ft = {
          lua = { "stylua" },
          javascript = jsFormatOptions(),
          javascriptreact = jsFormatOptions(),
          json = { "jq" },
        }
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
          conform.format({ bufnr = args.buf })
        end
      })
    end
  },
  {
    "numToStr/Comment.nvim",
    config = function()

      require("Comment").setup()
    end
  }
}
