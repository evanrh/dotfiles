local wezterm = require("wezterm")
local mux = wezterm.mux

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.wsl_domains = wezterm.default_wsl_domains()

local system = string.lower(wezterm.target_triple)

if string.find(system, "windows") then
	local domains = wezterm.default_wsl_domains()

	-- Setup launch menu for a Windows config
	config.launch_menu = {
		{
			label = "Powershell",
			args = { "powershell.exe" },
		},
		{
			label = "Command Prompt",
			args = { "cmd.exe" },
		},
	}

	-- Add WSL as the default domain if it is present
	if #domains > 0 then
		config.default_domain = domains[1].name
	end
end

if string.find(system, "apple") then
	config.font_size = 14
else
	config.font_size = 12
end

config.leader = { key = "Space", mods = "CTRL" }
config.keys = {
	{
		key = "|",
		mods = "LEADER|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "LeftArrow",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		key = "RightArrow",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		key = "Enter",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SpawnTab("DefaultDomain"),
	},
}

config.window_padding = {
	left = "1cell",
	right = "1cell",
	top = "0.5cell",
	bottom = "0.5cell",
}

wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window(cmd or {})
	local gui_window = window:gui_window()
end)

config.color_scheme = "Tokyo Night Storm"
config.enable_scroll_bar = true
config.native_macos_fullscreen_mode = true

-- Spawn a fish shell in login mode
-- config.default_prog = { "/usr/bin/env", "fish" }
return config
