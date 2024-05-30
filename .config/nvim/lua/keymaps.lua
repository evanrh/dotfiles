local result = {}
local wk = require("which-key")
local bufdelete = require("bufdelete")
local builtin = require("telescope.builtin")
local telescope = require("telescope")
local dap = require("dap")

function result.setup()

  vim.keymap.set("n", "<Esc>", function() vim.opt.hlsearch = not vim.opt.hlsearch:get() end)

  wk.register({
    w = {
      name = "+window",
      ["|"] = { function() vim.cmd(":vsplit") end, "Split window vertically" },
      ["-"] = { function() vim.cmd(":split") end, "Split window horizontally" },
      h = { function() vim.cmd(":wincmd h") end, "Move right" },
      j = { function() vim.cmd(":wincmd j") end, "Move down" },
      k = { function() vim.cmd(":wincmd k") end, "Move up" },
      l = { function() vim.cmd(":wincmd l") end, "Move left" },
      w = { function() vim.cmd(":wincmd w") end, "Move forward" },
      q = { function() vim.cmd(":quit") end, "Quit" }
    },
    b = {
      name = "+buffer",
      d = { bufdelete.bufdelete, "Delete buffer" },
      w = { bufdelete.bufwipeout, "Wipe out buffer" },
      ["["] = { function() vim.cmd(":bprevious") end, "Goto previous buffer" },
      ["]"] = { function() vim.cmd(":bprevious") end, "Goto previous buffer" },
    },
    f = {
      name = "+fuzzy find",
      f = { builtin.find_files, "Find files" },
      g = { builtin.live_grep, "Live grep current working dir" },
      G = { function () builtin.live_grep({ grep_open_files = true }) end, "Live grep open buffers" },
      b = { builtin.buffers, "Search active buffers" },
      h = { builtin.help_tags, "Search vim help" },
      m = { builtin.man_pages, "Search man pages" },
      e = { telescope.extensions.nerdy.nerdy, "Search Nerd Font Symbols" },
    },
    d = {
      name = "+debugger",
      b = { dap.toggle_breakpoint, "Toggle breakpoint" },
      r = { dap.continue, "Start / Continue debugger" },
      B = { telescope.extensions.dap.list_breakpoints, "List breakpoints" },
      i = { dap.step_into, "Step into" },
      I = { dap.step_out, "Step out" },
      o = { dap.step_over, "Step over" },
      q = { dap.terminate, "Quit session" },
      c = { function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, "Set conditional breakpoint" },
    },
    t = {
      name = "+terminal",
      o = { function() vim.cmd(":FloatermNew") end, "Open floating terminal" },
      t = { function() vim.cmd(":FloatermToggle") end, "Toggle floating terminal" },
    },
    o = {
      name = "+open",
      t = { function() vim.cmd(":FloatermNew") end, "Open floating terminal" },
      T = { function() vim.cmd(":Neotree toggle") end, "Toggle file tree to the left" },
    },
  }, { prefix = "<leader>" })
end

return result
