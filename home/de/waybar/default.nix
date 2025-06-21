{
  config,
  osConfig,
  ...
}:
let
  enable =
    if osConfig.features.hyprland.enable then
      osConfig.features.hyprland.bar == "waybar"
    # niri uses waybar
    else
      true;
in
{
  programs.waybar = {
    inherit enable;
  };
  # FIXME: dyn
  # xdg.configFile.waybar.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles_nix/.config/waybar";
}
