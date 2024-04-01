-- NOTE: Helpful article on configuring LSP and completions
-- https://vonheikemen.github.io/devlog/tools/setup-nvim-lspconfig-plus-nvim-cmp/

local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities();
local M = {}

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
    local bufmap = function(mode, lhs, rhs, desc)
      local opts = { buffer = ev.buf, desc = desc }
      vim.keymap.set(mode, lhs, rhs, opts)
    end
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

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
  end,
})

-- Base setup of mason and LSP handlers
function M.setup()
  mason.setup()
  mason_lspconfig.setup {
    ensure_installed = { "lua_ls", "tsserver", "cssls", "dockerls", "eslint", "jsonls", "tailwindcss", "svelte", },
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
        capabilities = capabilities
      }
    end
  }
end

return M
