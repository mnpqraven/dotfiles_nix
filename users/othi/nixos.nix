{ pkgs, ... }: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.othi = {
    isNormalUser = true;
    description = "othi";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [ kdePackages.kate ];
  };
  services.syncthing = { enable = true; };
}
