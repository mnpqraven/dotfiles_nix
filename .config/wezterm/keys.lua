local wezterm = require 'wezterm'
local act = wezterm.action
local module = {}

function module.apply_to_config(config)
  config.keys = {
    {
      key = 't',
      mods = 'SUPER|CTRL',
      action = act.SpawnTab 'CurrentPaneDomain'
    }
  }
end

return module
