local wezterm = require 'wezterm'

local config = {}
config.wsl_domains = wezterm.default_wsl_domains()

if wezterm.config_builder then
  config = wezterm.config_builder()
end


if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  -- Setup launch menu for a Windows config
  config.launch_menu = {
    {
      label = 'Powershell',
      args = { 'powershell.exe' }
    },
    {
      label = 'Command Prompt',
      args = { 'cmd.exe' }
    }
  }
end

config.color_scheme = 'Tokyo Night Storm'
config.enable_scroll_bar = true
config.font_size = 10
return config
