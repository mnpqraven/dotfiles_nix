{config, ...}: let
  cfg = "${config.home.homeDirectory}/dotfiles_nix/.config";
in {
  xdg.configFile."tofi".source =
    config.lib.file.mkOutOfStoreSymlink
    "${cfg}/tofi";
  # NOTE: or
  # home.file = {
  #   ".config/tofi" = {
  #     source = "${inputs.rootPath}/.config/tofi";
  #     recursive = true;
  #   };
  # };
}
