_:
let
  barBackground = false;
in
{
  programs.hyprpanel.settings.theme = {
    notification.enableShadow = true;
    osd.enableShadow = true;
    bar = {
      enableShadow = barBackground;
      transparent = !barBackground;
      menus.enableShadow = true;
      floating = barBackground;
    };
  };
}
