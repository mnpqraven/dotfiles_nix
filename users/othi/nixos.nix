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
  system.activationScripts.export-face-icon =
    let
      h = "/home/othi";
    in
    {
      deps = [ "etc" ];

      # TODO: dyn
      text = ''
        cp ${h}/dotfiles_nix/home/de/hyprpanel_assets/avatar.png ${h}
        mv ${h}/avatar.png ${h}/.face.icon
      '';
    };
  programs.dconf.enable = true;
}
