local wezterm = require('wezterm') --[[@as Wezterm]]
local act     = wezterm.action

---@param param CopyModeAssignment
local function cm_act(param)
  ---@diagnostic disable-next-line: undefined-field
  return wezterm.action.CopyMode(param)
end
local function extended_copy_mode()
  local default_copy_mode = wezterm.gui.default_key_tables().copy_mode
  ---@type Key[]
  local extends           = {
    { key = 'j', action = cm_act('MoveForwardWordEnd') },
    { key = 'h', action = cm_act('MoveLeft') },
    { key = 'n', action = cm_act('MoveDown') },
    { key = 'l', action = cm_act('MoveUp') },
    { key = 'e', action = cm_act('MoveRight') },
    { key = '%', action = cm_act('MoveToEndOfLineContent') },
    { key = 'E', action = cm_act('MoveToEndOfLineContent') },
    { key = 'H', action = cm_act('MoveToStartOfLine') },
    {
      key = 'N',
      mods = 'SHIFT',
      action = cm_act('MoveToViewportBottom')
    },
    {
      key = 'L',
      mods = 'SHIFT',
      action = cm_act('MoveToViewportTop')
    },
    {
      key = ';',
      mods = 'ALT',
      action = cm_act('MoveToSelectionOtherEndHoriz')
    }
  }
  if wezterm.gui then
    for _, row in pairs(extends) do
      table.insert(default_copy_mode, row)
    end
  end
  return default_copy_mode
end

---@class Config
return {
  keys = {
    -- pane navigation
    -- NOTE: this takes priority over zellij's navigation rn so you won't be able
    -- to navigate between zellij panes
    { key = 'h',          mods = 'ALT',       action = act.ActivatePaneDirection('Left') },
    { key = 'LeftArrow',  mods = 'ALT',       action = act.ActivatePaneDirection('Left') },
    { key = 'e',          mods = 'ALT',       action = act.ActivatePaneDirection('Right') },
    { key = 'RightArrow', mods = 'ALT',       action = act.ActivatePaneDirection('Right') },
    { key = 'l',          mods = 'ALT',       action = act.ActivatePaneDirection('Up') },
    { key = 'UpArrow',    mods = 'ALT',       action = act.ActivatePaneDirection('Up') },
    { key = 'n',          mods = 'ALT',       action = act.ActivatePaneDirection('Down') },
    { key = 'DownArrow',  mods = 'ALT',       action = act.ActivatePaneDirection('Down') },
    { key = '1',          mods = 'ALT',       action = act.ActivateTab(0) },
    { key = '2',          mods = 'ALT',       action = act.ActivateTab(1) },
    { key = '3',          mods = 'ALT',       action = act.ActivateTab(2) },
    { key = '4',          mods = 'ALT',       action = act.ActivateTab(3) },
    { key = '5',          mods = 'ALT',       action = act.ActivateTab(4) },
    { key = '6',          mods = 'ALT',       action = act.ActivateTab(5) },
    { key = '7',          mods = 'ALT',       action = act.ActivateTab(6) },
    { key = '8',          mods = 'ALT',       action = act.ActivateTab(7) },
    { key = '9',          mods = 'ALT',       action = act.ActivateTab(-1) },
    { key = 'h',          mods = 'ALT|SHIFT', action = act.ActivateTabRelative(-1) },
    { key = 'e',          mods = 'ALT|SHIFT', action = act.ActivateTabRelative(1) },
    -- actual wezterm control layer
    { key = 't',          mods = 'CTRL',      action = act.ActivateKeyTable({ name = 'pane_do' }) },
    {
      key = 'T',
      mods = 'CTRL|SHIFT',
      action = act.ActivateKeyTable({ name = 'pane_do', one_shot = false })
    },
    {
      key = 'x',
      mods = 'ALT',
      action = act.ActivateKeyTable({ name = 'pane_resize', one_shot = false })
    }
  },
  key_tables = {
    pane_do = {
      { key = 'Escape',     action = act.PopKeyTable },
      { key = '1',          action = act.ActivateTab(0) },
      { key = '2',          action = act.ActivateTab(1) },
      { key = '3',          action = act.ActivateTab(2) },
      { key = '4',          action = act.ActivateTab(3) },
      { key = '5',          action = act.ActivateTab(4) },
      { key = '6',          action = act.ActivateTab(5) },
      { key = '7',          action = act.ActivateTab(6) },
      { key = '8',          action = act.ActivateTab(7) },
      { key = '9',          action = act.ActivateTab(-1) },
      { key = 'h',          action = act.ActivatePaneDirection('Left') },
      { key = 'LeftArrow',  action = act.ActivatePaneDirection('Left') },
      { key = 'e',          action = act.ActivatePaneDirection('Right') },
      { key = 'RightArrow', action = act.ActivatePaneDirection('Right') },
      { key = 'l',          action = act.ActivatePaneDirection('Up') },
      { key = 'UpArrow',    action = act.ActivatePaneDirection('Up') },
      { key = 'n',          action = act.ActivatePaneDirection('Down') },
      { key = 'DownArrow',  action = act.ActivatePaneDirection('Down') },
      { key = 'r',          action = act.ActivateKeyTable({ name = 'pane_resize', one_shot = false }) },
      { key = 'c',          action = act.SpawnTab('CurrentPaneDomain') },
      { key = 'x',          action = act.CloseCurrentPane({ confirm = false }) },
      { key = 'X',          action = act.CloseCurrentTab({ confirm = false }) },
      { key = 'v',          action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },
      { key = 's',          action = act.SplitVertical({ domain = 'CurrentPaneDomain' }) },
      {
        key = 't',
        mods = 'CTRL',
        action = act.PopKeyTable
      },
      {
        key = 'T',
        mods = 'CTRL|SHIFT',
        action = act.PopKeyTable
      }
    },
    pane_resize = {
      { key = 'Escape',     action = act.PopKeyTable },
      { key = 'h',          action = act.AdjustPaneSize({ 'Left', 3 }) },
      { key = 'LeftArrow',  action = act.AdjustPaneSize({ 'Left', 3 }) },
      { key = 'e',          action = act.AdjustPaneSize({ 'Right', 3 }) },
      { key = 'RightArrow', action = act.AdjustPaneSize({ 'Right', 3 }) },
      { key = 'l',          action = act.AdjustPaneSize({ 'Up', 3 }) },
      { key = 'UpArrow',    action = act.AdjustPaneSize({ 'Up', 3 }) },
      { key = 'n',          action = act.AdjustPaneSize({ 'Down', 3 }) },
      { key = 'DownArrow',  action = act.AdjustPaneSize({ 'Down', 3 }) }
    },
    copy_mode = extended_copy_mode()
  }
}
