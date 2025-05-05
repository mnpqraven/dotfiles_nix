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
              rev = "f23ab14404bbf491de06819f3bdaf829cc0ba880";
              hash = "sha256-Lxu9x+LBnNOxEFE2CcQ3yiji4t2B9OIy1TW4jPDTJBk=";
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
