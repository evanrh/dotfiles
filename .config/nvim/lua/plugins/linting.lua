return {
  "mfussenegger/nvim-lint",
  config = function()
    local lint = require('lint')
    local jsLinters = { 'eslint_d' }
    lint.linters_by_ft = {
      javascript = jsLinters,
      javascriptreact = jsLinters,
      ['javascript.jsx'] = jsLinters,
      typescript = jsLinters,
      typescriptreact = jsLinters,
      ['typescript.tsx'] = jsLinters,
      htmlangular = jsLinters,
    }
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        -- try_lint without arguments runs the linters defined in `linters_by_ft`
        -- for the current filetype
        lint.try_lint()
      end,
})
  end
}
