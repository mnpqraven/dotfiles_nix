{
  lib,
  config,
  osConfig,
  ...
}:
lib.mkIf (builtins.elem "wezterm" osConfig.features.terminal.packages) {
  # TODO: dynamically grab theme from https://github.com/folke/tokyonight.nvim/blob/main/extras/alacritty
  programs.alacritty.enable = true;

  xdg.configFile.alacritty.source = config.lib.file.mkOutOfStoreSymlink "${osConfig.flake.repoPath}/.config/alacritty";
}
