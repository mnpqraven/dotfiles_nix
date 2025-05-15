{
  config,
  osConfig,
  ...
}:
{
  programs.waybar = {
    enable = osConfig.features.hyprland.bar == "waybar";
  };
  # FIXME: dyn
  xdg.configFile.waybar.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles_nix/.config/waybar";
}
