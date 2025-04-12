{
  inputs,
  pkgs,
  ...
}: let
  wpaperd = inputs.wpaperd.packages."${pkgs.system}".wpaperd;
  settings =
    if inputs.device == "pc"
    then {
      default = {
        duration = "1m";
        mode = "center";
        path = "/home/othi/wallpaper/horizontal";
      };
      "DP-2" = {
        duration = "1m";
        mode = "center";
        path = "/home/othi/wallpaper/vertical";
      };
    }
    else {
      default = {
        duration = "1m";
        mode = "center";
        path = "/home/othi/wallpaper/horizontal";
      };
    };
in {
  home.packages = with pkgs; [
    wpaperd
  ];
  programs.wpaperd.settings = settings;
}
