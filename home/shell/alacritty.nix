{
  config,
  inputs,
  pkgs,
  ...
}:
{
  programs = {
    alacritty = {
      enable = true;
      settings.window.opacity = 0.9;
    };
  };
}
