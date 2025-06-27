{
  osConfig,
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf
  (osConfig.features.notifications.enable && osConfig.features.desktops.hyprland.bar == "waybar")
  {
    nixpkgs.overlays = [
      (final: prev: {
        dunst = prev.dunst.overrideAttrs (old: {
          src = prev.fetchFromGitHub {
            owner = "bynect";
            repo = "dunst";
            rev = "f0506a0aaa770a4e1668e577539b729b97afbb0e";
            hash = "sha256-uMeeKciPeB6zmDvs9yOH+MNsCHLQDpWRpzoc5+hnveI=";
          };
        });
      })
    ];

    home.packages = with pkgs; [
      dunst
    ];
    xdg.configFile.dunst.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles_nix/.config/dunst";
  }
