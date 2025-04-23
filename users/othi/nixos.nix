_: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.othi = {
    isNormalUser = true;
    description = "othi";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };
  programs.dconf.enable = true;
}
