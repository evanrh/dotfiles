local result = {}
local wk = require("which-key")
local bufdelete = require("bufdelete")
local builtin = require("telescope.builtin")
local telescope = require("telescope")
local dap = require("dap")

local function winsplit(direction)
  return function() vim.cmd.wincmd(direction) end
end

function result.setup()

  vim.keymap.set("n", "<Esc>", function() vim.opt.hlsearch = not vim.opt.hlsearch:get() end)

  wk.add({
    { "<leader>w", group = "window" },
    { "<leader>w|", vim.cmd.vsplit, desc = "Split window vertically" },
    { "<leader>w-", vim.cmd.split , desc = "Split window horizontally" },
    { "<leader>wh", winsplit("h"), desc = "Move right" },
    { "<leader>wj", winsplit("j"), desc = "Move down" },
    { "<leader>wk", winsplit("k"), desc = "Move up" },
    { "<leader>wl", winsplit("l"), desc = "Move right" },
    { "<leader>ww", winsplit("w"), desc = "Move forward" },
    { "<leader>wq", vim.cmd.quit, desc = "Quit" },

    { "<leader>b", group = "buffer" },
    { "<leader>bd", bufdelete.bufdelete, desc = "Delete buffer" },
    { "<leader>bw", bufdelete.bufwipeout, desc = "Wipe out buffer" },
    { "<leader>b[", vim.cmd.bprevious, desc = "Goto previous buffer" },
    { "<leader>b]", vim.cmd.bnext, desc = "Goto next buffer" },

    { "<leader>f", group = "fuzzy find" },
    { "<leader>ff", builtin.find_files, desc = "Find files" },
    { "<leader>fg", builtin.live_grep, desc = "Live grep current working dir" },
    { "<leader>fG", function() builtin.live_grep.live_grep({ grep_open_files = true }) end, desc = "Live grep current working dir" },
    { "<leader>fb", builtin.buffers, desc = "Search active buffers" },
    { "<leader>fh", builtin.help_tags, desc = "Search vim help" },
    { "<leader>fm", builtin.man_pages, desc = "Search man pages" },
    { "<leader>fe", telescope.extensions.nerdy.nerdy, desc = "Search Nerd Font symbols" },
    { "<leader>fa", function() vim.lsp.buf.code_action() end, desc = "Search code actions" },

    { "<leader>d", group = "debugger" },
    { "<leader>db", dap.toggle_breakpoint, desc = "Toggle breakpoint" },
    { "<leader>dr", dap.continue, desc = "Start / Continue debugger" },
    { "<leader>dB", telescope.extensions.dap.list_breakpoints, desc = "List breakpoints" },
    { "<leader>di", dap.step_into, desc = "Step into" },
    { "<leader>dI", dap.step_out, desc = "Step out" },
    { "<leader>do", dap.step_over, desc = "Step over" },
    { "<leader>dq", dap.terminate, desc = "Quit session" },
    { "<leader>dc", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Set conditional breakpoint" },

    { "<leader>t", group = "tabs" },
    { "<leader>to", vim.cmd.tabnew, desc = "Open new tab" },
    { "<leader>t[", vim.cmd.tabprevious, desc = "Goto previous tab" },
    { "<leader>t]", vim.cmd.tabnext, desc = "Goto next tab" },
    { "<leader>tt", vim.cmd.tabnext, desc = "Goto next tab" },
    { "<leader>tq", vim.cmd.tabclose, desc = "Close tab" },

    { "<leader>o", group = "open" },
    { "<leader>ot", "<cmd>FloatermNew<cr>", desc = "Open floating terminal" },
    { "<leader>oT", "<cmd>Neotree toggle<cr>", desc = "Toggle file tree to the left" },
    { "<leader>ob", telescope.extensions.file_browser.file_browser, desc = "Open file browser" },
  })

end

return result
