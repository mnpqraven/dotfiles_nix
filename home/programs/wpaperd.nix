{
  inputs,
  pkgs,
  ...
}: let
  wpaperd = inputs.wpaperd.packages."${pkgs.system}".wpaperd;
  # creates an empty set if the condition isn't met, return the set otherwise
  when = {
    cond,
    monitor,
    set,
  }: {
    ${
      if cond
      then monitor
      else null
    } =
      set;
  };

  settings =
    {
      default = {
        duration = "1m";
        mode = "center";
        path = "/home/othi/wallpaper/horizontal";
      };
    }
    // when {
      cond = inputs.device == "pc";
      monitor = "DP-2";
      set = {
        duration = "1m";
        mode = "center";
        path = "/home/othi/wallpaper/vertical";
      };
    };
in {
  home.packages = [
    wpaperd
  ];
  programs.wpaperd = {
    enable = true;
    package = wpaperd;
    inherit settings;
  };
}
