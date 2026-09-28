# https://aottr.dev/posts/2024/08/homelab-setting-up-caddy-reverse-proxy-with-ssl-on-nixos/
{ pkgs, config, ... }:
{
  sops.secrets.ENV_ACME.owner = config.users.users.othi.name;

  security.acme = {
    acceptTerms = true;
    defaults.email = "mnpq.raven@gmail.com";

    certs."othi.dev" = {
      group = config.services.caddy.group;
      # https://go-acme.github.io/lego/dns/cloudflare/
      environmentFile = config.sops.secrets.ENV_ACME.path;

      domain = "othi.dev";
      extraDomainNames = [
        "*.hl.othi.dev"
        "*.othi.dev"
      ];
      dnsProvider = "cloudflare";
      dnsResolver = "127.0.0.53:53";

      # hacks to make self-signed certs work with mullvad
      dnsPropagationCheck = false; # mullvad vpn blocks
      extraLegoFlags = [ "--dns.propagation.wait=20s" ]; # avoid race condition with cloudflare
    };
  };
}
