{ inputs, config, ... }:
let
  # maps per device (inputs.device)
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
    ] ++ deviceMap.${inputs.device}.battery;
  };
  verticalLayout = {
    left = [ "workspaces" ];
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
    enable = true;
    overlay.enable = true;
    hyprland.enable = true;
    overwrite.enable = true;

    settings = {
      layout = deviceMap.${inputs.device}.layout;

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
