{ pkgs, ... }:
{
  imports = [
    ./mullvad.nix
    ./ssh.nix
    ./tailscale.nix
  ];
  services.resolved.enable = true;
  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    rsync
    openssl
    # debuging tools
    dig
    busybox
    iptables
  ];
}
