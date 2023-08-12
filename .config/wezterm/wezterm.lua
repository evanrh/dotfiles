local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end


if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  -- Do Windows things
end
config.color_scheme = 'Tokyo Night Storm'

return config