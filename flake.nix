{
  description = "Othi's system";

  inputs = {
    # for private submodules
    self.submodules = true;
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # helix.url = "github:helix-editor/helix/master"; # stable
    helix.url = "github:mnpqraven/helix/string-lsp-url"; # see helix-editor/helix#11889
    hyprland.url = "github:hyprwm/Hyprland";
    nvf.url = "github:notashelf/nvf";
    rmpc.url = "github:mierak/rmpc";
    swww.url = "github:LGFae/swww";
    yazi.url = "github:sxyazi/yazi";
    wallthi.url = "github:mnpqraven/wallthi";
    nix-secrets.url = "git+ssh://git@github.com/mnpqraven/nix-secrets.git?ref=main&shallow=1";
  };

  outputs =
    inputs:
    let
      utils = (import ./lib/utils.nix) { inherit inputs; };
    in
    with utils;
    {
      nixosConfigurations =
        { }
        // mkSystem {
          hostName = "pc";
          extraModules = [
            ./devices/dogshitasslogitechmouse.nix
          ];
        }
        // mkSystem { hostName = "pcremote"; }
        // mkSystem { hostName = "laptop"; }
        // mkSystem { hostName = "homelab"; };
    };
}
