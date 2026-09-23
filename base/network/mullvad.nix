{
  lib,
  config,
  pkgs,
  ...
}:
let
  mullvad = config.services.mullvad-vpn.package;
  bin = "${mullvad}/bin/mullvad";
  # TODO: login cond.
  account = config.sops.secrets.mullvad_account_number.path;

in
lib.mkIf config.features.services.vpn.enable {
  services.mullvad-vpn = {
    enable = true;
    gui.enable = config.features.services.vpn.gui.enable;
  };

  # @see https://discourse.nixos.org/t/connected-to-mullvadvpn-but-no-internet-connection/35803
  services.resolved.enable = true;
  systemd.services."mullvad-daemon" = {
    # TODO: connect if account get is null
    postStart = ''
      sleep 1
      ${bin} lan set allow
      ${bin} lockdown-mode set off # we don't need lockdown yet until ssh config is finished
      ${bin} tunnel set quantum-resistant on
      ${bin} tunnel set daita on
      ${bin} tunnel set daita-direct-only on
      ${bin} relay set location sg
      sleep 1
      ${bin} connect
    '';
  };

}
