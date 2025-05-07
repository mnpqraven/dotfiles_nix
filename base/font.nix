{
  lib,
  pkgs,
  ...
}:
{
  fonts.enableDefaultPackages = true;
  fonts.packages =
    with pkgs;
    [
      # japanese support
      source-han-code-jp
      notonoto
    ]
    ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  fonts.fontconfig = {
    defaultFonts = {
      serif = [
        "Noto Serif Display"
        "Source Han Code JP"
        "NOTONOTO"
      ];
      sansSerif = [
        "Liberation Sans"
        "NotoSans Nerd Font"
        "Source Han Code JP"
        "NOTONOTO"
      ];
      monospace = [
        "GeistMono NFM"
        "JetBrainsMono NFM"
        "Source Han Code JP"
        "NOTONOTO"
        "Noto Color Emoji"
      ];
    };
  };

}
