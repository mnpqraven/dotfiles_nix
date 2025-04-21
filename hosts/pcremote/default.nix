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

  services = {
    # Enable the X11 windowing system.
    # You can disable this if you're only using the Wayland session.
    xserver.enable = true;

    # Enable the KDE Plasma Desktop Environment.
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;

    # Enable CUPS to print documents.
    printing.enable = true;
  };

  programs.hyprland.enable = true;
  services.hypridle.enable = true;

  programs.hyprlock.enable = true;
  security.pam.services.hyprlock = { };

  security.rtkit.enable = true;

  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    dunst
    hyprpolkitagent
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
