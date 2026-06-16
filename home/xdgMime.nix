_: {
  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    # Images
    "image/*" = [ "feh.desktop" ];
    "image/png" = [ "feh.desktop" ];
    "image/jpeg" = [ "feh.desktop" ];
    "text/html" = [ "librewolf.desktop" ];
    "x-scheme-handler/http" = [
      "zen.desktop"
      "librewolf.desktop"
    ];
    "x-scheme-handler/https" = [
      "zen.desktop"
      "librewolf.desktop"
    ];
    "x-scheme-handler/about" = [
      "zen.desktop"
      "librewolf.desktop"
    ];
    "x-scheme-handler/unknown" = [
      "zen.desktop"
      "librewolf.desktop"
    ];
  };
}
