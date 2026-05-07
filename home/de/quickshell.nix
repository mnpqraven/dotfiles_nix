{
  pkgs,
  config,
  inputs,
  ...
}:
let
  symlink = config.lib.file.mkOutOfStoreSymlink;
  quickshell = inputs.qml-niri.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
in
{
  home.packages = with pkgs; [
    quickshell
    kdePackages.qtdeclarative
  ];
  xdg.configFile.quickshell = {
    target = "${config.home.homeDirectory}/.config/quickshell";
    source = symlink "${config.home.homeDirectory}/dotfiles_nix/.config/quickshell";
    recursive = true;
  };
}
