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
  };

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  };

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

  home-manager = {
    useGlobalPkgs = false;
    useUserPackages = true;
    users.othi = import ../../users/othi/home.nix;
    extraSpecialArgs = { inherit inputs; };
  };

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
