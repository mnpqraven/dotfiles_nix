{
  lib,
  config,
  osConfig,
  ...
}:
lib.mkIf (builtins.elem "wezterm" osConfig.features.terminal.packages) {
  programs.wezterm.enable = true;

  # FIXME: dyn
  xdg.configFile.wezterm.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles_nix/.config/wezterm";
}
