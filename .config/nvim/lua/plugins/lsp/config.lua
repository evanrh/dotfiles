-- NOTE: Helpful articles on configuring LSP, completions, and diagnostics
-- https://vonheikemen.github.io/devlog/tools/setup-nvim-lspconfig-plus-nvim-cmp/
-- https://smarttech101.com/nvim-lsp-diagnostics-keybindings-signs-virtual-texts/

local actions_preview = require("actions-preview")
local mason = require("mason")
local utils = require("utils")
local ts_tools = require("typescript-tools")
local M = {}

local goto_diagnostic = function(diagnostic_func)
  local diagnostics = vim.diagnostic.count(0)
  local count = utils.count_indices(diagnostics)

  if count == 0 then
    vim.print("'No diagnostics for current buffer'")
    return
  end

  vim.diagnostic.jump({
    diagnostic = diagnostic_func(),
    wrap = true,
    float = true,
  })
end

local goto_prev = function()
  goto_diagnostic(vim.diagnostic.get_prev)
end

local goto_next = function()
  goto_diagnostic(vim.diagnostic.get_next)
end

local signs = {
  { "Error", vim.diagnostic.severity.ERROR, "" },
  { "Warn", vim.diagnostic.severity.WARN, "" },
  { "Hint", vim.diagnostic.severity.HINT, "" },
  { "Info", vim.diagnostic.severity.INFO, "" },
}

local signsConfig = {
  text = {},
  linehl = {},
  texthl = {},
  numhl = {},
}

for _, mapping in pairs(signs) do
  local hl = "DiagnosticSign" .. mapping[1]
  local severity = mapping[2]
  signsConfig.text[severity] = mapping[3]
  signsConfig.numhl[severity] = hl
end

vim.diagnostic.config({
  signs = signsConfig,
})

-- Keymaps for LSP
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", goto_prev)
vim.keymap.set("n", "]d", goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local bufmap = function(mode, lhs, rhs, desc)
      local opts = { buffer = ev.buf, desc = desc }
      vim.keymap.set(mode, lhs, rhs, opts)
    end
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    if client ~= nil and client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true)
    end
    -- Buffer local mappings
    -- see `:help vim.lsp.*` for documentation on any of the below functions
    bufmap("n", "K", vim.lsp.buf.hover, "Show hover")
    bufmap("n", "gd", vim.lsp.buf.definition, "Go to definition")
    bufmap("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
    bufmap("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
    bufmap("n", "go", vim.lsp.buf.type_definition, "Go to type definition")
    bufmap("n", "gr", vim.lsp.buf.references, "List all references")
    bufmap("n", "gs", vim.lsp.buf.signature_help, "Display signature info")
    bufmap("n", "<F2>", vim.lsp.buf.rename, "Rename all references")
    bufmap("n", "<F4>", vim.lsp.buf.code_action, "Select a code action")
    bufmap("n", "gl", vim.diagnostic.open_float, "Show diagnostics")
    bufmap("n", "[d", goto_prev, "Goto previous diagnostic")
    bufmap("n", "]d", goto_next, "Goto next diagnostic")
    bufmap("n", "ga", actions_preview.code_actions, "View code actions")
  end,
})

-- Base setup of mason and LSP handlers
function M.setup()

  require("lspkind").init({
    mode = "symbol_text",
    preset = "default",
    symbol_map = {
      Text = "󰉿",
      Method = "󰆧",
      Function = "󰊕",
      Constructor = "",
      Field = "󰜢",
      Variable = "󰀫",
      Class = "󰠱",
      Interface = "",
      Module = "",
      Property = "󰜢",
      Unit = "󰑭",
      Value = "󰎠",
      Enum = "",
      Keyword = "󰌋",
      Snippet = "",
      Color = "󰏘",
      File = "󰈙",
      Reference = "󰈇",
      Folder = "󰉋",
      EnumMember = "",
      Constant = "󰏿",
      Struct = "󰙅",
      Event = "",
      Operator = "󰆕",
      TypeParameter = "",
    },
  })
  mason.setup()

  ts_tools.setup({
    settings = {
      separate_diagnostic_server = true,
      tsserver_file_preferences = {
        -- List of options located here:
        -- https://github.com/microsoft/TypeScript/blob/v5.0.4/src/server/protocol.ts#L3439
        includeInlayFunctionParameterTypeHints = false,
        includeInlayVariableTypeHints = false,
        includeInlayFunctionLikeReturnTypeHints = false,
        includePropertyDeclarationTypeHints = false,
      }
    }
  })
  vim.lsp.enable({ "lua_ls", "cssls", "jsonls", "yamlls" })
end

return M
