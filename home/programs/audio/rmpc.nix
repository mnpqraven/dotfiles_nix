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
              rev = "e6062d875ba43a52ed5408aca953f47feed32703";
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
