local M = {}
local companion = require("codecompanion")

function M.setup()
  companion.setup({
    strategies = {
      chat = {
        adapter = "openai",
      },
      inline = {
        adapter = "openai",
      },
      agent = {
        adapter = "openai",
      },
    },
    adapters = {
      http = {
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            schema = {
              model = {
                default = "claude-3",
              },
            },
          })
        end,
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            schema = {
              model = {
                default = "gpt-4o-mini",
              },
            },
            env = {
              api_key = "OPENAI_API_KEY",
            },
          })
        end,
      },
    }
  })
end

return M
