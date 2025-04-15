{
  lib,
  pkgs,
  ...
}:
{
  fonts.packages =
    with pkgs;
    [ source-han-code-jp ]
    ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  fonts.fontconfig = {
    defaultFonts = {
      serif = [
        "Noto Serif Display"
        "Source Han Code JP"
      ];
      sansSerif = [
        "Mononoki Nerd Font"
        "Source Han Code JP"
      ];
      monospace = [
        "Lilex Nerd Font Mono"
        "Source Han Code JP"
        "Noto Color Emoji"
      ];
    };
  };

}
