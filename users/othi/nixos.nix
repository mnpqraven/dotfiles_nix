{ pkgs, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.othi = {
    isNormalUser = true;
    description = "othi";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    packages = with pkgs; [ kdePackages.kate ];
  };
  # user profile for lockscreens
  system.activationScripts.export-face-icon = {
    deps = [ "etc" ];

    # TODO: dyn
    text = ''
      cp /home/othi/dotfiles_nix/home/de/hyprpanel_assets/avatar.jpg /home/othi
      mv /home/othi/avatar.jpg /home/othi/.face.icon
    '';
  };
  programs.dconf.enable = true;
}
