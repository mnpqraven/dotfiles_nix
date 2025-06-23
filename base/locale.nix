{ pkgs, config, ... }:
{
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  # Set your time zone.
  time.timeZone = "Asia/Ho_Chi_Minh";

  # if any gtk applications (e.g ghostty, waybar) hangs or crashes at launch,
  # it's likely fcitx5 being the culprit for calling the portal request too early
  # find the first one calling in `journalctl --user -b | $EDITOR`
  # @see https://github.com/NixOS/nixpkgs/issues/206630
  # this is fixed by setting up fcitx5 in system modules instead of home-manager
  # so far so good
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.waylandFrontend = config.features.wayland.enable;
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
      fcitx5-unikey
    ];
  };

  # @see https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland
  environment.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT4_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
  };
}
