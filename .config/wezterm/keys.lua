---@class Wezterm
---@diagnostic disable-next-line: assign-type-mismatch
local wezterm = require("wezterm")

local act = wezterm.action
local module = {}

---@param config Config
function module.config_mut(config)
  config.keys = {
    { key = "t", mods = "SUPER|CTRL", action = act.SpawnTab("CurrentPaneDomain") },
  }
end

return module
