{
  pkgs,
  inputs,
  ...
}:
let
  # TODO: flake lib
  nasMount = import ../../_fns/setupNasMounts.nix {
    addr = "192.168.1.14";
  };
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./gaming.nix
    # PC needs NVIDIA configs as well
    ./nvidia.nix
    nasMount
  ];

  networking.hostName = "pc";

  security.rtkit.enable = true;

  environment.systemPackages = with pkgs; [
    libnotify
    librewolf
    neovim
    git
  ];

  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--show-trace"
      "-L"
      "-v"
    ];
    dates = "weekly";
    randomizedDelaySec = "45min";
  };
}
