---@class Wezterm
local wezterm = require("wezterm")

---@type Config
local config = wezterm.config_builder()

require("keys").apply_to_config(config)

---@diagnostic disable-next-line: missing-fields
config = {
  color_scheme = "tokyonight",
  font = wezterm.font_with_fallback({ "JetBrainsMono NFM", "Source Han Code JP", "Noto Color Emoji" }),
  font_size = 12,
  hide_tab_bar_if_only_one_tab = true,
  window_background_opacity = 0.8,
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
}

return config
