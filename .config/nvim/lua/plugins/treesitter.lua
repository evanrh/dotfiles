return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
    "nvim-treesitter/nvim-treesitter-context",
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "javascript",
        "svelte",
        "json",
        "tsx",
      },
      sync_install = false,
      auto_install = true,
      ignore_install = {},
      modules = {},
      indent = {
        enable = true,
      },
      highlight = {
        enable = true,
        disable = function(_, buf)
          local max_filesize = 100 * 1024
          local ok, stats =
            pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
          return ok and stats and stats.size > max_filesize
        end,
      },
    })

    require("treesitter-context").setup()

    require("nvim-ts-autotag").setup({
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
      },
    })

    vim.o.foldmethod = "expr"
    vim.o.foldexpr = "nvim_treesitter#foldexpr()"
    vim.o.foldenable = false
  end,
}
