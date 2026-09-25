{ lib, config, ... }: {
  # TODO: differentiate between clients and servers
  # current pov: nixos wiki
  services.tailscale = {
    enable = true;
    # required for *.ts.net MagicDNS names to resolve
    extraSetFlags = [ "--accept-dns=true" ];
  };

  networking.firewall = {
    enable = true;
    trustedInterfaces = [ config.services.tailscale.interfaceName ];
    allowedUDPPorts = [ config.services.tailscale.port ];
  };

  # 2. Force tailscaled to use nftables (Critical for clean nftables-only systems)
  # This avoids the "iptables-compat" translation layer issues.
  systemd.services.tailscaled.serviceConfig.Environment = [
    "TS_DEBUG_FIREWALL_MODE=nftables"
  ];

  # 3. Optimization: Prevent systemd from waiting for network online
  # (Optional but recommended for faster boot with VPNs)
  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;

  # INFO: mullvad integration
  # https://codeberg.org/jackr/nixos/src/commit/4904ca631a082cb137f249d2fb0b129971a4c322/mods/tailscale.nix#L69
  # https://discourse.nixos.org/t/anyone-running-both-mullvad-and-tailscale-both-wireguard/17136/6?u=shortcut
  #
  # Allow tailscale to work around mullvad
  # https://theorangeone.net/posts/tailscale-mullvad/
  # prio needs to be -100
  networking.nftables.tables.mullvad_tailscale = lib.mkIf config.features.services.vpn.enable {
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
