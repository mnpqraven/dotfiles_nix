{ inputs, ... }:
let
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
    ] ++ laptopWidgets;
  };
  verticalLayout = {
    left = [ "workspaces" ];
    middle = [ "media" ];
    right = [ ];
  };

  laptopWidgets = if inputs.device == "laptop" then [ "battery" ] else [ ];
  # FIXME: dyn
  username = "othi";
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
      layout = {
        "bar.layouts" = {
          "0" = horizontalLayout;
          "1" = verticalLayout;
          "2" = horizontalLayout;
        };
      };

      menus.clock = {
        time = {
          military = true;
          hideSeconds = false;
        };
        weather = {
          enabled = true;
          unit = "metric";
          location = "Ha Noi";
          key = "/home/${username}/.config/hyprpanel/weather.json";
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
