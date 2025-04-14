{
  config,
  inputs,
  ...
}: let
  cfg = "${config.home.homeDirectory}/dotfiles_nix/.config";
  symlink = config.lib.file.mkOutOfStoreSymlink;
in {
  xdg.configFile = {
    helix.source = symlink "${cfg}/helix";
    hypr.source = symlink "${cfg}/hypr";
    macchina.source = symlink "${cfg}/macchina";
    "starship.toml".source = symlink "${cfg}/starship.toml";
    tofi.source = symlink "${cfg}/tofi";
    zellij.source = symlink "${cfg}/zellij";
    clifm.source = symlink "${cfg}/clifm";
    wezterm.source = symlink "${cfg}/wezterm";
    yazi.source = symlink "${cfg}/yazi";
  };
  # dynamically creates hyprland config
  # FIXME: new installation needs to run 2 different builds, each build with
  # one file section commented out to correctly populate the symlinks
  home.file.".config/hypr/hyprland.conf" = {
    force = true;
    text = ''
      source = ./hyprland/set.conf

      source = ./hyprland/monitors_${inputs.device}.conf
      source = ./hyprland/startup.conf
      source = ./hyprland/wallpaper_${inputs.device}.conf
      source = ./hyprland/animations.conf
      source = ./hyprland/rules.conf
      source = ./hyprland/bindings.conf
      source = ./hyprland/looks.conf
    '';
  };
}
