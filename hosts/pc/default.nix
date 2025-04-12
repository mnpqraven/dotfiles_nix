{
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # WIP: NVIDIA CONFIGURATION
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.nvidia.open = true;
  services.xserver.videoDrivers = ["nvidia"];

  networking.hostName = "pc";

  # Set your time zone.
  time.timeZone = "Asia/Ho_Chi_Minh";

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

  services.hypridle.enable = true;
  programs = {
    hyprland.enable = true;
    hyprlock.enable = true;
    zsh.enable = true;
  };
  security.pam.services.hyprlock = {};

  security.rtkit.enable = true;

  virtualisation.docker.enable = true;

  users.defaultUserShell = pkgs.zsh;

  environment.systemPackages = with pkgs; [
    dunst
    hyprpolkitagent
    libnotify
    librewolf
    neovim
    nixd
    git
    nixfmt-rfc-style
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
