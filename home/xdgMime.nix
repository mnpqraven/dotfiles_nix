_: {
  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    # Images
    "image/*" = ["feh.desktop"];
    "image/png" = ["feh.desktop"];
    "image/jpeg" = ["feh.desktop"];
    "text/html" = ["librewolf.desktop"];
    "x-scheme-handler/http" = ["librewolf.desktop"];
    "x-scheme-handler/https" = ["librewolf.desktop"];
    "x-scheme-handler/about" = ["librewolf.desktop"];
    "x-scheme-handler/unknown" = ["librewolf.desktop"];
  };
}
