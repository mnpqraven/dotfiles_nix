{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.features.hyprland.enable {
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  };
  environment.systemPackages = with pkgs; [
    hyprcursor
    rose-pine-hyprcursor
  ];
}
