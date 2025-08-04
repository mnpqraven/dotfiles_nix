{
  inputs,
  osConfig,
  config,
  ...
}:
let
  device = osConfig.networking.hostName;
  monitorMap = {
    pc = {
      "DP-1".resolution = "2560x1440";
      "DP-2" = {
        resolution = "1080x1920";
        vertical = true;
        transform = 90; # note: hyprland is 1
      };
      "DP-3".resolution = "1920x1080";
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
  generalMap = {
    pc = {
      duration = 60;
      path = [ "${config.home.homeDirectory}/wallpaper/horizontal" ];
      path_vertical = [ "${config.home.homeDirectory}/wallpaper/vertical" ];
    };
    pcremote = {
      duration = 60;
      path = [ "${config.home.homeDirectory}/wallpaper/horizontal" ];
      path_vertical = [ "${config.home.homeDirectory}/wallpaper/vertical" ];
    };
    laptop = {
      duration = 60;
      path = [ "${config.home.homeDirectory}/wallpaper/laptop" ];
    };
  };

  monitor = monitorMap.${device};
  general = generalMap.${device};

in
{
  imports = [
    inputs.wallthi.homeManagerModules.default
  ];
  programs.wallthi = {
    enable = true;
    settings = {
      inherit monitor general;
    };
  };
}
