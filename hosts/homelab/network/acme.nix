# https://aottr.dev/posts/2024/08/homelab-setting-up-caddy-reverse-proxy-with-ssl-on-nixos/
{ pkgs, config, ... }:
{
  sops.secrets.ENV_ACME.owner = config.users.users.othi.name;

  security.acme = {
    acceptTerms = true;
    defaults.email = "mnpq.raven@gmail.com";

    certs."hl.othi.dev" = {
      group = config.services.caddy.group;

      domain = "hl.othi.dev";
      extraDomainNames = [ "*.hl.othi.dev" ];
      dnsProvider = "cloudflare";
      dnsResolver = "1.1.1.1:53";
      dnsPropagationCheck = true;
      # https://go-acme.github.io/lego/dns/cloudflare/
      environmentFile = config.sops.secrets.ENV_ACME.path;
    };
  };
}
