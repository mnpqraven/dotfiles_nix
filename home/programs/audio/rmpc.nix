{
  pkgs,
  config,
  ...
}:
let
  rmpc = pkgs.rmpc.override {
    # @see https://discourse.nixos.org/t/is-it-possible-to-override-cargosha256-in-buildrustpackage/4393/20
    rustPlatform = pkgs.rustPlatform // {
      buildRustPackage =
        args:
        pkgs.rustPlatform.buildRustPackage (
          args
          // {
            src = pkgs.fetchFromGitHub {
              owner = "mierak";
              repo = "rmpc";
              rev = "4aac99f8f6788cfa9763462d53ff05e45cbd745a";
              hash = "sha256-Ch4ujxciizEkt4pGBLm8quxEuGqVaKHKvMpi9UGmhsA=";
            };
            cargoHash = "sha256-7wd3cN1P0CXM8MGgvIZ4+WAC+0bOtY9asRf3WW8sxFc=";
          }
        );
    };
  };
in
{
  home.packages = [
    rmpc
  ];
  # FIXME: dyn
  xdg.configFile."rmpc".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles_nix/.config/rmpc";
}
