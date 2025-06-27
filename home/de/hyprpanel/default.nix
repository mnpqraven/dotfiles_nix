{
  inputs,
  config,
  osConfig,
  ...
}:
let
  # maps per device
  deviceMap = {
    laptop = {
      battery = [ "battery" ];
      layout = {
        "bar.layouts" = {
          "0" = horizontalLayout;
        };
      };
    };
    pc = {
      layout = {
        "bar.layouts" = {
          "0" = horizontalLayout;
          "1" = verticalLayout;
          "2" = horizontalLayout;
        };
      };
      battery = [ ];
    };
    pcremote = {
      layout = {
        "bar.layouts" = {
          "0" = horizontalLayout;
          "1" = horizontalLayout;
        };
      };
      battery = [ ];
    };
  };

  horizontalLayout = {
    left = [
      "dashboard"
      "workspaces"
      "windowtitle"
    ];
    middle = [ "media" ];
    right = [
      "volume"
      "systray"
      "network"
      "notifications"
      "clock"
    ] ++ deviceMap.${osConfig.networking.hostName}.battery;
  };
  verticalLayout = {
    left = [
      "dashboard"
      "workspaces"
    ];
    middle = [ "media" ];
    right = [ "clock" ];
  };
in
{
  imports = [
    inputs.hyprpanel.homeManagerModules.hyprpanel
    ./bar.nix
    ./theme.nix
    ./dashboard.nix
    ./notification.nix
  ];

  programs.hyprpanel = {
    enable = osConfig.features.desktops.hyprland.bar == "hyprpanel";
    overlay.enable = true;
    hyprland.enable = true;
    overwrite.enable = true;

    settings = {
      layout = deviceMap.${osConfig.networking.hostName}.layout;

      menus.clock = {
        time = {
          military = true;
          hideSeconds = false;
        };
        weather = {
          enabled = true;
          unit = "metric";
          location = "Ha Noi";
          key = "${config.home.homeDirectory}/.config/hyprpanel/weather.json";
        };
      };

      theme.name = "tokyo_night";

      theme.font = {
        name = "CaskaydiaCove NF";
        size = "16px";
      };
    };
  };
}
