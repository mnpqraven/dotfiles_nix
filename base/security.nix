{ config, ... }:
{
  security.rtkit.enable = true;
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
    };
    templates = { };
  };
}
