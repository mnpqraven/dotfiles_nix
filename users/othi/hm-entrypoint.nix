_:
let
  username = "othi";
in
{
  imports = [
    ../../home
  ];

  programs.home-manager.enable = true;

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "24.11";
  };

  # user profile for lockscreens
  home.file.".face.icon" = {
    source = ../../docs/imgs/avatar.png;
    force = true;
  };

  nixpkgs.config.allowUnfree = true;
}
