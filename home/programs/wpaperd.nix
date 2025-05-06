{
  inputs,
  osConfig,
  ...
}:
let
  # creates an empty set if the condition isn't met, return the set otherwise
  when =
    {
      cond,
      monitor,
      set,
    }:
    {
      ${if cond then monitor else null} = set;
    };
  inherit (inputs) username;

  settings =
    {
      default = {
        duration = "1m";
        mode = "center";
        path = "/home/${username}/wallpaper/horizontal";
      };
    }
    // when {
      cond = osConfig.networking.hostName == "pc";
      monitor = "DP-2";
      set = {
        duration = "1m";
        mode = "center";
        path = "/home/${username}/wallpaper/vertical";
      };
    };
in
{
  services.wpaperd = {
    enable = true;
    inherit settings;
  };
}
