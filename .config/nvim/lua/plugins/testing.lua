return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "marilari88/neotest-vitest"
  },
  config = function ()
    require("neotest").setup({
      adapters = {
        require("neotest-vitest")({
          is_test_file = function (file_path)
            if file_path == nil then
              return false
            end
            local is_test_file = false

            if string.match(file_path, "__tests__") then
              is_test_file = true
            end

            for _, x in ipairs({ "e2e", "spec", "test", "vitest" }) do
              for _, ext in ipairs({ "js", "jsx", "coffee", "ts", "tsx" }) do
                if string.match(file_path, "%." .. x .. "%." .. ext .. "$") then
                  is_test_file = true
                  goto matched_pattern
                end
              end
            end
            ::matched_pattern::
            return is_test_file
          end
        })
      }
    })
  end
}
