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
              rev = "c8cdc7b176ffa77e790bcbeaf459c8b68f57a7f8";
              hash = "sha256-dMFqofhhRsibw3D09JLGWK4Zk8n353OCvTV3+G6hAes=";
            };
            cargoHash = "sha256-xXH/MRQgT/Je/aOCZ26vdC3PtlosXLIrjbOHtnvf9os=";
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
