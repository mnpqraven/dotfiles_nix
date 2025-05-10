local wezterm = require('wezterm') --[[@as Wezterm]]

---@class Config
return {
  color_scheme = 'tokyonight',
  font = wezterm.font_with_fallback({
    'JetBrainsMono NFM',
    'Source Han Code JP',
    'Noto Color Emoji'
  }),
  font_size = 12,
  window_background_opacity = 0.8,
  window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
}
