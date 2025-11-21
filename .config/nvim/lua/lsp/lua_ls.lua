local capabilities = require("cmp_nvim_lsp").default_capabilities()
return {
  cmd = { 'lua-language-server' },
  capabilities = capabilities,
  filetypes = { 'lua' },
  root_markers = {
    '.emmyrc.json',
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git',
  },
  settings = {
    Lua = {
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true)
      }
    }
  }
}
