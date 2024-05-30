-- NOTE: Helpful articles on configuring LSP, completions, and diagnostics
-- https://vonheikemen.github.io/devlog/tools/setup-nvim-lspconfig-plus-nvim-cmp/
-- https://smarttech101.com/nvim-lsp-diagnostics-keybindings-signs-virtual-texts/

local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities();
local actions_preview = require("actions-preview")
local M = {}

local signs = {
  Error = "",
  Warn = "",
  Hint = "✏️",
  Info = "",
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
-- Keymaps for LSP
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local bufmap = function(mode, lhs, rhs, desc)
      local opts = { buffer = ev.buf, desc = desc }
      vim.keymap.set(mode, lhs, rhs, opts)
    end
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

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
    bufmap("n", "[d", vim.diagnostic.goto_prev, "Goto previous diagnostic")
    bufmap("n", "]d", vim.diagnostic.goto_next, "Goto next diagnostic")
    bufmap("n", "ga", actions_preview.code_actions, "View code actions")
  end,
})

-- Base setup of mason and LSP handlers
function M.setup()

  require("nvim-lightbulb").setup({
    -- NOTE: Items pulled from LSP spec: https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#codeActionKind
    action_kinds = { "quickfix", "refactor.inline", "refactor.rewrite", "source.organizeImports", "source.fixAll" },
    autocmd = {
      enabled = true
    },
    virtual_text = {
      enabled = true,
    },
    sign = {
      enabled = false,
    },
    ignore = {
      actions_without_kind = true,
    }
  })

  require('lspkind').init({
    mode = 'symbol_text',
    preset = 'default',
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
  mason_lspconfig.setup {
    ensure_installed = {
      "lua_ls",
      "tsserver",
      "cssls",
      "dockerls",
      "eslint",
      "jsonls",
      "tailwindcss",
      "svelte",
      "angularls",
    },
    automatic_installation = true,
    ui = { check_outdated_servers_on_open = true },
  }

  mason_lspconfig.setup_handlers {
    eslint = function()
      lspconfig.eslint.setup {
        root_dir = lspconfig.util.root_pattern(
        "eslint.config.js",
        ".eslintrc.js",
        ".eslintrc.json",
        ".eslintrc"
        ),
      }
    end,

    lua_ls = function()
      lspconfig.lua_ls.setup {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            }
          }
        }
      }
    end,

    tsserver = function()
      lspconfig.tsserver.setup {
        capabilities = capabilities,
        settings = {
          implicitProjectConfiguration = {
            checkJs = false
          },
          typescript = {
            inlayHints = {
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includePropertyDeclarationTypeHints = true,
            }
          },
          javascript = {
            inlayHints = {
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includePropertyDeclarationTypeHints = true,
            }
          },
        }
      }
    end,

    angularls = function()
      lspconfig.angularls.setup({})
    end,

    cssls = function()
      lspconfig.cssls.setup({
        capabilities = capabilities,
      })
    end
  }
end

return M
