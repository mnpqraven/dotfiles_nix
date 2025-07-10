{
  inputs,
  ...
}:
{
  imports = [
    inputs.wallthi.homeManagerModules.default
  ];
  programs.wallthi = {
    enable = true;
    settings = {
      general = {
        # TODO: by hosts
        duration = 60;
        path = [ "/home/othi/wallpaper/horizontal" ];
        path_vertical = [ "/home/othi/wallpaper/vertical" ];
      };

      monitor = {
        "HDMI-A-1".resolution = "1920x1080";
      };
    };
  };
}
