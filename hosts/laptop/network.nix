{ inputs, ... }:
with inputs.nix-secrets.work;
{
  networking = { inherit hosts; };
  security.pki = { inherit certificates; };
}
