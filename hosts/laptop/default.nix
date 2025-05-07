{
  pkgs,
  inputs,
  ...
}:
let
  nasMount = import ../../_fns/setupNasMounts.nix {
    addr = "192.168.1.14";
  };
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    nasMount
  ];

  networking.hostName = "laptop";

  services.xserver.xkb = {
    layout = "us,";
    variant = "colemak,";
    options = "grp:win_space_toggle";
  };

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
