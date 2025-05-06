---@class Wezterm
local wezterm = require("wezterm")

local config = wezterm.config_builder()

require("keys").config_mut(config)

config.color_scheme = "tokyonight"
config.font = wezterm.font_with_fallback({ "JetBrainsMono NFM", "Source Han Code JP", "Noto Color Emoji" })
config.font_size = 12
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.8
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

return config
