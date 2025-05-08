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
              rev = "8daf632587669aa60cc1d6071625aa47bd39ca63";
              hash = "sha256-m0/4hwSIE0p35uhyeS6kUaLUwvR5S52mM3Zqzlbizm0=";
            };
            cargoHash = "sha256-RQ0ibBFkVq7KgYrbMeIgTBSDJbCLCea/ThhbJgOuKxk=";
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
