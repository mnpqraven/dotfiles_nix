local wezterm      = require 'wezterm' --[[@as Wezterm]]
local nf           = wezterm.nerdfonts
local LEFT_SYMBOL  = wezterm.nerdfonts.pl_right_hard_divider
local RIGHT_SYMBOL = wezterm.nerdfonts.pl_left_hard_divider
local F            = require 'utils'
local module       = {}

function module.setup()
  wezterm.on('format-tab-title', function(tab, _, _, config)
    --@ref https://github.com/wezterm/wezterm/discussions/628#discussioncomment-10675526
    local pane       = tab.active_pane
    local title      = F.tab_title(tab)
    local tab_number = tostring(tab.tab_index + 1)
    local colors     = wezterm.get_builtin_color_schemes()[config.color_scheme]

    -- Shrink title if too long
    if string.len(title) > config.tab_max_width - 3 then
      title = string.sub(title, 1, config.tab_max_width - 12) .. '.. '
    end

    -- Add copy icon
    if string.match(pane.title, '^Copy mode:') then
      title = nf.md_content_copy .. ' ' .. title
    end

    local final_title = tab_number .. ' ' .. title

    if tab.is_active then
      return {
        { Background = { Color = colors.background } },
        { Foreground = { Color = colors.tab_bar.active_tab.bg_color } },
        { Text = LEFT_SYMBOL },
        { Background = { Color = colors.tab_bar.active_tab.bg_color } },
        { Foreground = { Color = colors.background } },
        { Text = final_title },
        { Background = { Color = colors.background } },
        { Foreground = { Color = colors.tab_bar.active_tab.bg_color } },
        { Text = RIGHT_SYMBOL }
      }
    else
      return {
        { Background = { Color = colors.background } },
        { Foreground = { Color = colors.tab_bar.inactive_tab.bg_color } },
        { Text = LEFT_SYMBOL },
        { Background = { Color = colors.tab_bar.inactive_tab.bg_color } },
        { Foreground = { Color = colors.foreground } },
        { Text = final_title },
        { Background = { Color = colors.background } },
        { Foreground = { Color = colors.tab_bar.inactive_tab.bg_color } },
        { Text = RIGHT_SYMBOL }
      }
    end
  end)
end

return module
