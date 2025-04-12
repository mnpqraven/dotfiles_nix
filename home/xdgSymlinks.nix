{
  config,
  inputs,
  ...
}: let
  cfg = "${config.home.homeDirectory}/dotfiles_nix/.config";
  symlink = config.lib.file.mkOutOfStoreSymlink;
in {
  # TODO: different sources based on device platform
  xdg.configFile = {
    helix.source = symlink "${cfg}/helix";
    hypr.source =
      if inputs.device == "pc"
      then symlink "${cfg}/hypr_pc"
      else symlink "${cfg}/hypr";
    "hypr.monitors.conf".source =
      if symlink inputs.device == "pc"
      then "${cfg}/hypr/monitors_pc.conf"
      else symlink "${cfg}/hypr/monitors_laptop.conf";
    macchina.source = symlink "${cfg}/macchina";
    "starship.toml".source = symlink "${cfg}/starship.toml";
    tofi.source = symlink "${cfg}/tofi";
    zellij.source = symlink "${cfg}/zellij";
    clifm.source = symlink "${cfg}/clifm";
    # TODO: sees if "wpaperd/config.toml" works
    wpaperd.source =
      if inputs.device == "pc"
      then symlink "${cfg}/wpaperd_pc"
      else symlink "${cfg}/wpaperd";
  };
}
