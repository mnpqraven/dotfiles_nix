{ ... }: {
  services.mullvad-vpn = {
    enable = true;
    # TODO: dyn
    gui.enable = true;
  };

  # @see https://discourse.nixos.org/t/connected-to-mullvadvpn-but-no-internet-connection/35803
  services.resolved.enable = false;
}
