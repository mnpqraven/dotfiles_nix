{ pkgs, ... }: {
  services.resolved.enable = true;

  environment.systemPackages = with pkgs; [
    pritunl-client
  ];
}
