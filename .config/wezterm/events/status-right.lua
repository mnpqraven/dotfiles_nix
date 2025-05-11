local wezterm      = require 'wezterm' --[[@as Wezterm]]
local module       = {}
local LEFT_SYMBOL  = wezterm.nerdfonts.pl_right_hard_divider
local RIGHT_SYMBOL = wezterm.nerdfonts.pl_left_hard_divider
local color_scheme = require 'config.ui'.color_scheme
local colors       = wezterm.get_builtin_color_schemes()[color_scheme]

---@class ExtraColor
---@field dark_grey_i number
---@field red_i number
---@field green_i number
---@field yellow_i number
---@field blue_i number
---@field purple_i number
---@field cyan_i number
---@field grey_i number
---@return ExtraColor
local ec           = {
  dark_grey_i = 1,
  red_i       = 2,
  green_i     = 3,
  yellow_i    = 4,
  blue_i      = 5,
  purple_i    = 6,
  cyan_i      = 7,
  grey_i      = 8
}

---@param text string
---@param color_index number
---@return FormatItem[]
local function create_segment(text, color_index)
  return {
    { Background = { Color = colors.background } },
    { Foreground = { Color = colors.ansi[color_index] } },
    { Text = LEFT_SYMBOL },
    { Background = { Color = colors.ansi[color_index] } },
    { Foreground = { Color = colors.background } },
    { Text = text },
    { Background = { Color = colors.background } },
    { Foreground = { Color = colors.ansi[color_index] } },
    { Text = RIGHT_SYMBOL }
  }
end

---@param mode string | nil
local function render_status_segment(mode)
  if mode == nil then
    return create_segment('NORMAL', ec.green_i)
  end

  if mode == 'copy_mode' then
    return create_segment('COPY', ec.yellow_i)
  end
  if mode == 'pane_do' then
    return create_segment('PANE', ec.blue_i)
  end
  -- any other mode
  return create_segment(mode, ec.purple_i)
end

---@return FormatItem[]
local function render_user_segment()
  local hostname = wezterm.hostname()
  return create_segment(hostname, ec.purple_i)
end

---@param window Window
local function render_workspace_segment(window)
  local title = window:active_workspace()
  if title == nil then
    return {}
  elseif title == 'default' then
    return {}
  else
    return create_segment(title, ec.purple_i)
  end
end

function module.setup()
  wezterm.on('update-status', function(window, pane)
    local key_table         = window:active_key_table()
    local right_status      = {}

    local status_segment    = render_status_segment(key_table)
    local user_segment      = render_user_segment()
    local workspace_segment = render_workspace_segment(window)

    for _, row in pairs(status_segment) do
      table.insert(right_status, row)
    end
    for _, row in pairs(user_segment) do
      table.insert(right_status, row)
    end
    for _, row in pairs(workspace_segment) do
      table.insert(right_status, row)
    end

    window:set_right_status(wezterm.format(right_status))
  end)
end

return module
