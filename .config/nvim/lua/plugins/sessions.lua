return {
  "rmagatti/auto-session",
  config = function()
    require("auto-session").setup({
      log_level = "error",
      auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
      session_lens = {
        buftypes_to_ignore = {},
        load_on_setup = true,
        theme_conf = { border = true },
        previewer = false,
      }
    })

    vim.keymap.set("n", "<leader>fs",
      require("auto-session.session-lens").search_session,
      { noremap = true, desc = "Search sessions" }
    )

    require("telescope").load_extension("session-lens")
  end
}
