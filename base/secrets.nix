{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [
    age
    sops
  ];

  # https://zohaib.me/managing-secrets-in-nixos-home-manager-with-sops/
  # https://michael.stapelberg.ch/posts/2025-08-24-secret-management-with-sops-nix/
  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    age = {
      sshKeyPaths = [ "/home/othi/.ssh/id_ed25519" ];
      keyFile = "/home/othi/.config/sops/age/keys.txt";
      generateKey = true;
    };

    secrets = {
      # This is the actual specification of the secrets.
      mullvad_account_number = { };
      nas_user = {
        restartUnits = [ "nas-credentials.service" ];
      };
      nas_password = {
        restartUnits = [ "nas-credentials.service" ];
      };
      syncthing_password = {
        restartUnits = [ "syncthing.service" ];
        group = config.users.groups.syncthing.name; # so the service can read the password file
      };
    };
  };
}
