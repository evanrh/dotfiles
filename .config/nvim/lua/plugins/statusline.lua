return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local auto_session = require("auto-session.lib")
    require("lualine").setup {
      options = {
        icons_enabled = true,
        theme = "auto",
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename",  auto_session.current_session_name },
        lualine_x = { "buffers" },
        lualine_y = { "encoding", "fileformat", "filetype" },
        lualine_z = { "location" },
      },
    }
  end,
}
