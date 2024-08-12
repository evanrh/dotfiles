local result = {}
local telescope = require("telescope");

function result.setup()
  local extensions = {
    "file_browser",
    "ui-select",
  }

  for _, v in pairs(extensions) do
    telescope.load_extension(v)
  end
end

return result
