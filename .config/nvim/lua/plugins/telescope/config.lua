local result = {}
local builtin = require("telescope.builtin")

function result.setup()
  require("telescope").load_extension("file_browser")
end

return result
