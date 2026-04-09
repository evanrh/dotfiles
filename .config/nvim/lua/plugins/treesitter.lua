local function auto_install_parsers()
  local ensure_installed = {
    "c",
    "lua",
    "vim",
    "vimdoc",
    "query",
    "javascript",
    "json",
    "tsx",
    "angular",
    "json5",
    "html"
  }
  local already_installed = require('nvim-treesitter.config').get_installed()
  local parsers_to_install = vim.iter(ensure_installed)
    :filter(function (parser)
      return not vim.tbl_contains(already_installed, parser)
    end)
    :totable()
  require('nvim-treesitter').install(parsers_to_install)
end

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  -- build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
    -- "romus204/tree-sitter-manager.nvim",
    "nvim-treesitter/nvim-treesitter"
  },
  init = function()
    -- require("tree-sitter-manager").setup()
    require("nvim-treesitter").setup()

    require("treesitter-context").setup()

    require("nvim-ts-autotag").setup({
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
      },
    })

    vim.api.nvim_create_autocmd('FileType', {
      callback = function ()
        pcall(vim.treesitter.start)
        vim.wo[0][0].foldmethod = "expr"
        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    })
    vim.o.foldenable = false
    auto_install_parsers()
  end,
}
