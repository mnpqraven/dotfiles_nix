{ inputs, config, ... }:
{
  imports = [
    inputs.hyprpanel.homeManagerModules.hyprpanel
    ./bar.nix
    ./dashboard.nix
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
            left = [
              "dashboard"
              "workspaces"
            ];
            middle = [ "media" ];
            right = [
              "volume"
              "systray"
              "notifications"
            ];
          };
        };
      };

      menus.clock = {
        time = {
          military = true;
          hideSeconds = true;
        };
        weather.unit = "metric";
      };

      theme.name = "tokyo_night_moon_split";

      theme.font = {
        name = "CaskaydiaCove NF";
        size = "16px";
      };
    };
  };
}
