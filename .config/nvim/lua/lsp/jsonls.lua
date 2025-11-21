local capabilities = require("cmp_nvim_lsp").default_capabilities()
return {
  cmd = { 'vscode-json-language-server', '--stdio' },
  capabilities = capabilities,
  filetypes = { 'json', 'jsonc' },
  init_options = {
    provideFormatter = true,
  },
  root_markers = { '.git' },
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true }
    }
  }
}
