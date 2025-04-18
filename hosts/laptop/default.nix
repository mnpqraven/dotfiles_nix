{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "laptop";

  # Set your time zone.
  time.timeZone = "Asia/Ho_Chi_Minh";

  services = {
    # Enable the X11 windowing system.
    # You can disable this if you're only using the Wayland session.
    xserver = {
      enable = true;
      xkb = {
        layout = "us,";
        variant = "colemak,";
        options = "grp:win_space_toggle";
      };
    };

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
  security.pam.services.hyprlock = { };

  security.rtkit.enable = true;

  virtualisation.docker.enable = true;

  users.defaultUserShell = pkgs.zsh;

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
