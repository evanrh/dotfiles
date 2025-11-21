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
        picker = "telescope",
      }
    })

    require("telescope").load_extension("session-lens")
  end
}
