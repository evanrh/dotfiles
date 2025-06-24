local result = {}
local telescope = require("telescope")

function result.setup()
  local extensions = {
    "file_browser",
    "ui-select",
    "ast_grep",
  }

  for _, v in pairs(extensions) do
    telescope.load_extension(v)
  end

  telescope.setup({
    extensions = {
      ast_grep = {
        command = {
          "sg",
          "--json=stream",
        },
        grep_open_files = false,
        lang = nil,
      },
    },
  })
end

return result
