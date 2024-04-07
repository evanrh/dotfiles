return {
  "gelguy/wilder.nvim",
  config = function()
    local wilder = require("wilder")

    wilder.set_option("renderer", wilder.popupmenu_renderer(
      wilder.popupmenu_border_theme({
        highlighter = wilder.basic_highlighter(),
        min_width = "100%",
      })
    ))
    wilder.setup({
      modes = { ":", "/", "?" },
    })

  end
}
