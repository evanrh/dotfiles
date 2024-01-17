local wezterm = require 'wezterm'
local mux = wezterm.mux

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.wsl_domains = wezterm.default_wsl_domains()

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
	local domains = wezterm.default_wsl_domains()

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

	-- Add WSL as the default domain if it is present
	if #domains > 0 then
		config.default_domain = domains[1].name
	end

end

wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window(cmd or {})
	local gui_window = window:gui_window()
	gui_window:perform_action(wezterm.action.ToggleFullScreen, pane)
end)

config.color_scheme = 'Tokyo Night Storm'
config.enable_scroll_bar = true
config.font_size = 16
config.native_macos_fullscreen_mode = true
return config
