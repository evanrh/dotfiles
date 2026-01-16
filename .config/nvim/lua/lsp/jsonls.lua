return {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  init_options = {
    provideFormatter = true,
  },
  root_markers = { '.git' },
  settings = {
    json = {
      validate = { enable = true }
    }
  },
  before_init = function(_, config)
    config.settings.json.schemas = require('schemastore').json.schemas()
  end
}
