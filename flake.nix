{
  description = "Othi's system";

  inputs = {
    # for private submodules
    # self.submodules = true;
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix = {
      url = "github:helix-editor/helix/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    rmpc = {
      url = "github:mierak/rmpc";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    yazi = {
      url = "github:sxyazi/yazi";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wallthi = {
      url = "github:mnpqraven/wallthi";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vps = {
      # submodule memes, see https://github.com/NixOS/nix/issues/13571
      url = "git+https://github.com/mnpqraven/vps?ref=homelab&submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-secrets.url = "git+ssh://git@github.com/mnpqraven/nix-secrets.git?ref=main&shallow=1";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.home-manager.follows = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helium = {
      url = "github:AlvaroParker/helium-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    qml-niri = {
      url = "github:imiric/qml-niri/main";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell";
    };
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
        // mkBaseless {
          hostName = "homelab";
          extraModules = [
            ./base
          ];
        };
    };
}
