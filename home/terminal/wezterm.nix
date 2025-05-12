{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    wezterm
  ];
  # FIXME: dyn
  xdg.configFile.wezterm.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles_nix/.config/wezterm";
}
