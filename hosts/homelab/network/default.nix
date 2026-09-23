{ ... }: {
  imports = [
    ./caddy.nix
  ];

  networking.nftables = {
    enable = true;
    # ssh through vpn
    # connection tracking mark (0x00000f41) to get through the firewall
    # and a meta mark (0x6d6f6c65) to route the traffic outside the tunnel
    # @see https://wiki.nftables.org/wiki-nftables/index.php/Setting_packet_metainformation#packet_mark_and_conntrack_mark
    ruleset = ''
      table inet excludeTraffic {
        chain allowIncoming {
          type filter hook input priority -100; policy accept;
          tcp dport 22 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
        }
        chain allowOutgoing {
          type route hook output priority -100; policy accept;
          tcp sport 22 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
        }
      }
    '';

    # tailscale might need this for mullvad
    # https://codeberg.org/jackr/nixos/src/commit/4904ca631a082cb137f249d2fb0b129971a4c322/mods/tailscale.nix#L69
    # https://discourse.nixos.org/t/anyone-running-both-mullvad-and-tailscale-both-wireguard/17136/6?u=shortcut
  };
}
