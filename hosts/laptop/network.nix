{ inputs, ... }:
with inputs.nix-secrets.work;
{
  # TODO: grab from sops
  networking = { inherit hosts; };
  security.pki = { inherit certificates; };
}
