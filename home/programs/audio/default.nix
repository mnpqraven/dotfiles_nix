_: {
  services.easyeffects.enable = true;
  imports = [
    ./mpd.nix
    ./rmpc.nix
  ];
}
