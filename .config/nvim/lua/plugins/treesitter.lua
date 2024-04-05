return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag"
  },
  config = function()
    require("nvim-treesitter.configs").setup{
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "svelte", "json" },
      autotag = { enable = true },
      sync_install = false,
      auto_install = true,
      ignore_install = {},
      modules = {},
    }
  end
}
