-- NOTE: Great article on configuring DAP
-- https://miguelcrespo.co/posts/how-to-debug-like-a-pro-using-neovim

local result = {}
local telescope = require("telescope")

function result.setup()

  local dap = require("dap")
  local dapui = require("dapui")

  dap.defaults.fallback.exception_breakpoints = { "uncaught" }

  -- Setup DAP UI to run when DAP plugin loads
  dap.listeners.before.attach.dapui_config = dapui.open
  dap.listeners.before.launch.dapui_config = dapui.open
  dap.listeners.before.event_terminated.dapui_config = dapui.close
  dap.listeners.before.event_exited.dapui_config = dapui.close

  require("dap-vscode-js").setup({
    debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
    adapters = { "pwa-node", "node" },
    log_file_level = vim.log.levels.DEBUG,
  })

  require("nvim-dap-virtual-text").setup()
  telescope.load_extension("dap")

  dapui.setup({
    layouts = { {
      elements = { {
        id = "repl",
        size = 1
      } },
      position = "bottom",
      size = 10
    }, {
      elements = { {
        id = "scopes",
        size = 0.5
      }, {
        id = "breakpoints",
        size = 0.5
      } },
      position = "left",
      size = 30
    },  {
      elements = { {
        id = "console",
        size = 0.5
      }, {
        id = "watches",
        size = 0.5
      } },
      position = "right",
      size = 30
    } }
  })

  -- Setup proper signs for DAP
  vim.fn.sign_define("DapBreakpoint", { text="🛑", texthl="", linehl="", numhl="" })
  vim.fn.sign_define("DapStopped", { text="▶️", texthl="", linehl="", numhl="" })

  local javascriptLangs = { "javascript", "typescript" }

  for _, language in ipairs(javascriptLangs) do
    dap.configurations[language] = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach",
        processId = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
      },
    }
  end

  require("dap.ext.vscode").load_launchjs(nil, { ["pwa-node"] = javascriptLangs })
end

return result
