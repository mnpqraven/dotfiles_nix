_: {
  "custom/pad" = {
    format = " ";
    interval = "once";
    tooltip = false;
  };
  "custom/padd" = {
    format = "  ";
    interval = "once";
    tooltip = false;
  };
  "group/group-power" = {
    orientation = "inherit";
    drawer = {
      transition-duration = 200;
      children-class = "not-power";
      transition-left-to-right = false;
    };
    modules = [
      "custom/power"
      "custom/quit"
      "custom/lock"
      "custom/reboot"
    ];
  };
  "custom/quit" = {
    format = "󰗼 ";
    tooltip-format = "Log out";
    on-click = "hyprctl dispatch exit";
  };
  "custom/lock" = {
    format = "󰍁 ";
    tooltip-format = "Lock";
    on-click = "hyprlock";
  };
  "custom/reboot" = {
    format = "󰜉 ";
    tooltip = false;
    on-click = "reboot";
  };
  "custom/power" = {
    format = " ";
    tooltip = false;
    on-click = "shutdown now";
  };

}
