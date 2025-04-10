{
  self,
  inputs,
  config,
  ...
}: {
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
          "0" = {
            left = ["dashboard" "workspaces" "windowtitle"];
            middle = ["media"];
            right = [
              "volume"
              "systray"
              "network"
              "notifications"
              "clock"
              "battery"
            ];
          };
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
          key = builtins.readFile ../../.weatherapi;
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
