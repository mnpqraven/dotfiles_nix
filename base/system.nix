{ pkgs, config, ... }: {
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # wayland wrapper flag for electron and chromium apps
  environment.sessionVariables.NIXOS_OZONE_WL = 1;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages = with pkgs; [
    libnotify
    neovim
    git
  ];

  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;
  programs.nh = {
    enable = true;
    flake = config.flake.repoPath;
    clean = {
      enable = true;
      extraArgs = "--keep 3 --keep-since 7d";
    };
  };

  users.defaultUserShell = pkgs.zsh;

  system.stateVersion = "24.11"; # Did you read the comment?
}
