{ ... }:
let
  flake = "/home/othi/dotfiles_nix";
in
{
  programs.nh = {
    enable = true;
    # TODO: dyn
    inherit flake;
    clean = {
      enable = true;
      extraArgs = "--keep 5 --keep-since 7d";
    };
  };
}
