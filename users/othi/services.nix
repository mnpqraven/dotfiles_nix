_:
let
  # TODO: might be better with relative path to home
  # but this is a system service so ??
  homeDir = "/home/othi";
  allDevices = [
    "nas"
    "home-windows"
    "phone"
    "laptop"
    "work-pc"
  ];
in
{
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
        id = "5K3L44F-4WJP5OL-OM6Y3JS-QH7DCOQ-PXR6MTQ-DCFWT5F-VNKSJBS-3CJVUA4";
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
        id = "QH4MEVC-F7ZD5I3-6DBMGUX-KJDO3JM-XD33LV6-2A44EGF-OENTMAP-2ZTYHQQ";
      };
      "walkman" = {
        id = "XIUXJTF-GOLZLTP-DLUCQHZ-D44NDVV-LSNZYAE-ZR4G6V7-EXSLEZE-YRVVBQW";
      };
    };
    settings.folders = {
      "${homeDir}/Sync" = {
        id = "default";
        devices = allDevices;
      };
      "${homeDir}/wallpaper" = {
        id = "rdvnk-hham6";
        devices = allDevices;
      };
      "${homeDir}/WalkmanMusic" = {
        id = "urrvx-iogrd";
        devices = [
          "walkman"
          "phone"
        ];
      };
    };
  };
}
