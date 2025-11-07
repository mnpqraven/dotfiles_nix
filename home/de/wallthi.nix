{
  inputs,
  osConfig,
  config,
  ...
}:
let
  device = osConfig.networking.hostName;
  paths = {
    horizontal = "${config.home.homeDirectory}/wallpaper/horizontal";
    vertical = "${config.home.homeDirectory}/wallpaper/vertical";
    laptop = "${config.home.homeDirectory}/wallpaper/laptop";
  };
  monitorMap = {
    pc = {
      "DP-1".resolution = "2560x1440";
      "DP-2" = {
        resolution = "1080x1920";
        vertical = true;
        transform = 90; # note: hyprland is 1
      };
      "HDMI-A-1".resolution = "1920x1080";
    };
    pcremote = {
      "HDMI-A-1".resolution = "1920x1080";
      "DP-1".resolution = "1920x1080";
    };
    laptop = {
      "eDP-1".resolution = "1920x1200";
      "HDMI-A-1".resolution = "1920x1080";
    };
    homelab = { };
  };
  generalMap = with paths; {
    pc = {
      duration = 60;
      path = [ horizontal ];
      path_vertical = [ vertical ];
    };
    pcremote = {
      duration = 60;
      path = [ horizontal ];
      path_vertical = [ vertical ];
    };
    laptop = {
      duration = 60;
      path = [ laptop ];
    };
  };
in
{
  imports = [
    inputs.wallthi.homeManagerModules.default
  ];
  programs.wallthi = {
    enable = true;
    settings = {
      monitor = monitorMap.${device};
      general = generalMap.${device};
    };
  };
}
