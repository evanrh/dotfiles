return {
  {
    "gelguy/wilder.nvim",
    lazy = true,
    config = function()
      local wilder = require("wilder")

      wilder.set_option(
        "renderer",
        wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
          highlighter = wilder.basic_highlighter(),
          min_width = "100%",
        }))
      )
      wilder.setup({
        modes = { ":", "/", "?" },
      })
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function ()
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          }
        },
        presets = {
          bottom_search = true,
        },
        views = {
          cmdline_popup = {
            position = {
              row = 5,
              col = "50%"
            },
            size = {
              width = 60,
              height = "auto"
            }
          },
          popupmenu = {
            relative = "editor",
            position = {
              row = 8,
              col = "50%"
            },
            size = {
              width = 60,
              height = 10,
            },
            border = {
              style = "rounded",
              padding = { 0, 1 },
            },
            win_options = {
              winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" }
            }
          }
        }
      })
    end
  }
}
