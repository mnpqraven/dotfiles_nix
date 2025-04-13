_: let
  # TODO: might be better with relative path to home
  # but this is a system service so ??
  homeDir = "/home/othi";
in {
  # Syncthing ports: 8384 for remote access to GUI
  # 22000 TCP and/or UDP for sync traffic
  # 21027/UDP for discovery
  # source: https://docs.syncthing.net/users/firewall.html
  networking.firewall.allowedTCPPorts = [
    22000
  ];
  networking.firewall.allowedUDPPorts = [
    22000
    21027
  ];
  services.syncthing = {
    enable = true;
    user = "othi";
    # NOTE: this needs to be a persistent dir, else this device's ID will
    # change after every rebuild
    configDir = "${homeDir}/.config/syncthing";
    dataDir = homeDir;
    settings.devices = {
      "nas" = {
        id = "3ASBY6N-OS6RGSV-ZP64Z7U-MDYTZUA-74TWJT7-K5N2IG6-PE4NEFF-UOK7OA2";
      };
      "home-windows" = {
        id = "4JUS3IL-GWYHS2K-6MT6VGA-NXPR5MS-7ZGDX4E-UWMAMHY-PVTUJ7R-PM7BFQN";
      };
      "home-nixos" = {
        id = "3CHVA4S-4RGRIP6-ANRKFBX-5TRMW45-FUABOR5-34FQ377-J7YVZPI-QLNHTQS";
      };
      "laptop" = {
        id = "CJ3B3XZ-2KBXIQU-YLPK6VZ-ERTFNAO-QWRG5XI-FFDK6IO-F6I3Z6Z-B7HBKQ4";
      };
      "phone" = {
        id = "6TOUADK-ULRBSQH-ZUVOQD4-5LLMZF3-6NUMMU6-HZFEWDE-OTPLWR7-FJMRVAH";
      };
      "work-pc" = {
        id = "N52ZUJZ-X5WHA3R-QEQ7B4C-6PXI2TS-453CFVG-FOIQOWK-VWSUORC-X564DQV";
      };
    };
    settings.folders = {
      "${homeDir}/Sync" = {
        id = "default";
        devices = [
          "nas"
          "home-windows"
          "phone"
          "work-pc"
        ];
      };
      "${homeDir}/wallpaper/horizontal" = {
        id = "6gvcf-t5xvr";
        devices = [
          "nas"
          "home-windows"
          "phone"
          "work-pc"
        ];
      };
      "${homeDir}/wallpaper/vertical" = {
        id = "xba9c-zdahz";
        devices = [
          "nas"
          "home-windows"
          "phone"
          "work-pc"
        ];
      };
    };
  };
}
