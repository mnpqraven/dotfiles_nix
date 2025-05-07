{
  pkgs,
  inputs,
  ...
}:
let
  nasMount = import ../../_fns/setupNasMounts.nix {
    addr = "nas.othi.dev";
  };
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    nasMount
  ];

  networking.hostName = "pcremote";

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
