_: {
  "hyprland/window" = {
    max-length = 120;
    icon = false;
    icon-size = 13;
  };
  "hyprland/workspaces" = {
    format = "{icon} {name}";
    format-icons = {
      default = "";
      active = "";
    };
  };
  "hyprland/submap" = {
    on-click = "hyprctl dispatch submap reset";
    max-length = 16;
    tooltip = false;
  };

  "niri/workspaces" = {
    format = "{icon}";
    format-icons = {
      default = "";
      active = "";
    };
  };
}
