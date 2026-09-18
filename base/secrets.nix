{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    age
    sops
  ];
  security.rtkit.enable = true;

  # https://zohaib.me/managing-secrets-in-nixos-home-manager-with-sops/
  # https://michael.stapelberg.ch/posts/2025-08-24-secret-management-with-sops-nix/
  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    age = {
      # This will automatically import SSH keys as age keys
      sshKeyPaths = [ "/home/othi/.ssh/id_ed25519" ];
      # This is using an age key that is expected to already be in the filesystem
      keyFile = "/home/othi/.config/sops/age/keys.txt";
      # This will generate a new key if the key specified above does not exist
      generateKey = true;
    };

    secrets = {
      # This is the actual specification of the secrets.
      mullvad_account_number = {
        restartUnits = [ "mullvad-autostart.service" ];
      };
      nas_user = {
        restartUnits = [ "nas-credentials.service" ];
      };
      nas_password = {
        restartUnits = [ "nas-credentials.service" ];
      };
    };
  };
}
