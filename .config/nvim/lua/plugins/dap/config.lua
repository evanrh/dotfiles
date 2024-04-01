-- NOTE: Great article on configuring DAP
-- https://miguelcrespo.co/posts/how-to-debug-like-a-pro-using-neovim
--
local result = {}
local telescope = require("telescope")

function result.setup()

  local dap = require("dap")
  local dapui = require("dapui")

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

  dapui.setup()

  -- Setup proper signs for DAP
  vim.fn.sign_define("DapBreakpoint", { text="🛑", texthl="", linehl="", numhl="" })
  vim.fn.sign_define("DapStopped", { text="▶️", texthl="", linehl="", numhl="" })

  for _, language in ipairs({ "typescript", "javascript"}) do
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
      }
    }
  end

  local javascriptLangs = { "javascript", "typescript" }

  require("dap.ext.vscode").load_launchjs(nil, { ["pwa-node"] = javascriptLangs })

  vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
  vim.keymap.set("n", "<leader>dr", dap.continue, { desc = "Start / Continue debugger" })
  vim.keymap.set("n", "<leader>dB", telescope.extensions.dap.list_breakpoints, { desc = "List breakpoints" })
  vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
  vim.keymap.set("n", "<leader>dI", dap.step_out, { desc = "Step out" })
  vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })

end

return result
