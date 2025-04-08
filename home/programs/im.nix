{inputs, ...}: {
  home.file = {
    ".config/fcitx5" = {
      source = "${inputs.rootPath}/.config/fcitx5";
      recursive = true;
    };
  };
}
