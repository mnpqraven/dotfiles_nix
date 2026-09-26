# references
# TS + mullvad integration
# @see https://codeberg.org/jackr/nixos/src/commit/4904ca631a082cb137f249d2fb0b129971a4c322/mods/tailscale.nix
{
  lib,
  config,
  pkgs,
  ...
}:
let
  hasMullvad = config.features.services.vpn.enable;
in
{
  services.tailscale = {
    enable = true;
    # required for *.ts.net MagicDNS names to resolve
    # makes tailscale handle dns resolutions
    extraSetFlags = [ "--accept-dns=true" ];
  };

  networking.firewall = {
    enable = true;
    checkReversePath = "loose";
    trustedInterfaces = [ config.services.tailscale.interfaceName ];
    allowedUDPPorts = [ config.services.tailscale.port ];
  };

  systemd.services.tailscaled = {
    after = lib.mkIf hasMullvad [ "mullvad.daemon.service" ];
    serviceConfig = {
      # 2. Force tailscaled to use nftables (Critical for clean nftables-only systems)
      # This avoids the "iptables-compat" translation layer issues.
      Environment = [
        "TS_DEBUG_FIREWALL_MODE=nftables"
      ];
      ExecStartPre = [ "${lib.getExe' pkgs.coreutils "sleep"} 5" ];
      ExecStart = [
        ""
        "/run/wrappers/bin/mullvad-exclude ${lib.getExe' pkgs.tailscale "tailscaled"} --state=/var/lib/tailscale/tailscaled.state --socket=/run/tailscale/tailscaled.sock --port=\${PORT} $FLAGS"
      ];
    };
    startLimitBurst = 10;
    startLimitIntervalSec = 0;
  };

  # 3. Optimization: Prevent systemd from waiting for network online
  # (Optional but recommended for faster boot with VPNs)
  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;

  # INFO: mullvad integration
  # https://codeberg.org/jackr/nixos/src/commit/4904ca631a082cb137f249d2fb0b129971a4c322/mods/tailscale.nix#L69
  # https://discourse.nixos.org/t/anyone-running-both-mullvad-and-tailscale-both-wireguard/17136/6?u=shortcut

  # Allow tailscale to work around mullvad
  # https://theorangeone.net/posts/tailscale-mullvad/
  # prio needs to be -100
  networking.nftables.tables.mullvad_tailscale = lib.mkIf hasMullvad {
    family = "inet";
    content = ''
      chain output {
        type route hook output priority -100; policy accept;
        ip daddr 100.64.0.0/10 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
      }
      chain input {
        type filter hook input priority -100; policy accept;
        ip saddr 100.64.0.0/10 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
      }
    '';
  };
}
