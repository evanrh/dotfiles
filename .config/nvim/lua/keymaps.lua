local result = {}
local actions = require("telescope.actions")
local actions_state = require("telescope.actions.state")
local bufdelete = require("bufdelete")
local builtin = require("telescope.builtin")
local conform = require("conform")
local telescope = require("telescope")
local wk = require("which-key")

local function winsplit(direction)
  return function()
    vim.cmd.wincmd(direction)
  end
end

local function buffer_search()
  builtin.buffers({
    sort_mru = true,
    ignore_current_buffer = false,
    show_all_buffers = true,
    attach_mappings = function(prompt_bufnr, map)
      local refresh = function()
        actions.close(prompt_bufnr)
        vim.schedule(buffer_search)
      end

      local delete = function()
        local selection = actions_state.get_selected_entry()
        bufdelete.bufdelete({ selection.bufnr })
        refresh()
      end

      map("n", "dd", delete)
      return true
    end,
  })
end

function result.setup()
  vim.keymap.set("n", "<Esc>", function()
    vim.o.hlsearch = not vim.o.hlsearch
  end)

  wk.add({
    { "<leader>w", group = "window" },
    { "<leader>w|", vim.cmd.vsplit, desc = "Split window vertically" },
    { "<leader>w-", vim.cmd.split, desc = "Split window horizontally" },
    { "<leader>wh", winsplit("h"), desc = "Move right" },
    { "<leader>wj", winsplit("j"), desc = "Move down" },
    { "<leader>wk", winsplit("k"), desc = "Move up" },
    { "<leader>wl", winsplit("l"), desc = "Move right" },
    { "<leader>ww", winsplit("w"), desc = "Move forward" },
    { "<leader>wW", winsplit("W"), desc = "Move backward" },
    { "<leader>wb", winsplit("W"), desc = "Move backward" },
    { "<leader>wq", vim.cmd.quitall, desc = "Quit All" },
    { "<leader>wQ", vim.cmd.quit, desc = "Quit" },
    {
      "<leader>w=",
      function()
        vim.cmd("vertical wincmd =")
        vim.cmd("horizontal wincmd =")
      end,
      desc = "Even window splits",
    },

    { "<leader>b", group = "buffer" },
    { "<leader>bd", bufdelete.bufdelete, desc = "Delete buffer" },
    { "<leader>bw", bufdelete.bufwipeout, desc = "Wipe out buffer" },
    { "<leader>b[", vim.cmd.bprevious, desc = "Goto previous buffer" },
    { "<leader>b]", vim.cmd.bnext, desc = "Goto next buffer" },

    { "<leader>f", group = "fuzzy find" },
    { "<leader>ff", builtin.find_files, desc = "Find files" },
    { "<leader>fg", builtin.live_grep, desc = "Live grep current working dir" },
    {
      "<leader>fG",
      function()
        builtin.live_grep({ grep_open_files = true })
      end,
      desc = "Live grep current working dir",
    },
    { "<leader>fb", buffer_search, desc = "Search active buffers" },
    { "<leader>fh", builtin.help_tags, desc = "Search vim help" },
    { "<leader>fm", builtin.man_pages, desc = "Search man pages" },
    {
      "<leader>fc",
      function()
        vim.lsp.buf.code_action()
      end,
      desc = "Search code actions",
    },
    {
      "<leader>fa",
      telescope.extensions.ast_grep.ast_grep,
      desc = "Live AST grep",
    },

    { "<leader>l", group = "LSP" },
    {
      "<leader>lc",
      function()
        vim.lsp.buf.code_action()
      end,
      desc = "Search code actions",
    },
    {
      "<leader>ln",
      function()
        vim.lsp.buf.rename()
      end,
      desc = "Rename symbol at cursor",
    },
    {
      "<leader>lr",
      function()
        vim.lsp.buf.references()
      end,
      desc = "List references to symbol",
    },

    { "<leader>t", group = "tabs" },
    { "<leader>to", vim.cmd.tabnew, desc = "Open new tab" },
    { "<leader>t[", vim.cmd.tabprevious, desc = "Goto previous tab" },
    { "<leader>t]", vim.cmd.tabnext, desc = "Goto next tab" },
    { "<leader>tt", vim.cmd.tabnext, desc = "Goto next tab" },
    { "<leader>tq", vim.cmd.tabclose, desc = "Close tab" },

    { "<leader>o", group = "open" },
    { "<leader>ot", "<cmd>FloatermNew<cr>", desc = "Open floating terminal" },
    {
      "<leader>ob",
      telescope.extensions.file_browser.file_browser,
      desc = "Open file browser",
    },
    { "<leader>ou", vim.cmd.UndotreeToggle, desc = "Open undotree" },
    {
      "<leader>os",
      "<cmd>Spectre<cr>",
      desc = "Open Spectre for search / replace",
    },

    { "<leader>n", group = "Neotree" },
    { "<leader>nn", "<cmd>Neotree toggle<cr>", desc = "Toggle Neotree" },
    { "<leader>nf", "<cmd>Neotree focus<cr>", desc = "Focus Neotree" },
    {
      "<leader>nF",
      "<cmd>Neotree position=float<cr>",
      desc = "Open Neotree floating",
    },
    {
      "<leader>nh",
      "<cmd>Neotree position=left<cr>",
      desc = "Open Neotree on the left",
    },
    {
      "<leader>nl",
      "<cmd>Neotree position=right<cr>",
      desc = "Open Neotree on the right",
    },
    {
      "<leader>nj",
      "<cmd>Neotree position=bottom<cr>",
      desc = "Open Neotree on the bottom",
    },
    {
      "<leader>nk",
      "<cmd>Neotree position=top<cr>",
      desc = "Open Neotree on the top",
    },

    { "<leader>v", group = "vim" },
    {
      "<leader>vf",
      function()
        conform.format({ bufnr = 0 })
      end,
      desc = "Format current buffer",
    },

    { "<leader>a", group = "ai" },
    { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "Open AI actions" },
    {
      "<leader>ac",
      "<cmd>CodeCompanionChat<cr>",
      desc = "Open an AI chat prompt",
    },

    { "<leader>q", group = "Quickfix" },
    {
      "<leader>qo",
      vim.cmd.copen,
      desc = "Open quickfix",
    },
    {
      "<leader>qc",
      vim.cmd.cclose,
      desc = "Close quickfix",
    },
    {
      "<leader>q[",
      vim.cmd.cprevious,
      desc = "Go to previous entry",
    },
    {
      "<leader>q]",
      vim.cmd.cnext,
      desc = "Go to next entry",
    },

    { "S", "<cmd>Spectre<cr>", desc = "Open Spectre for search / replace" },
  })
end

return result
