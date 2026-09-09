{
  lib,
  osConfig,
  pkgs,
  ...
}:
lib.mkIf (builtins.elem "zen" osConfig.features.webBrowser.browsers) {
  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
    profiles.default.presets.betterfox.enable = true;
    profiles.default.settings = {
      "browser.warnOnQuit" = false;
      "browser.warnOnQuitShortcut" = false;
    };
    # @see https://github.com/nix-community/home-manager/blob/master/modules/programs/firefox/profiles/search.nix
    profiles.default.search = {
      force = true;
      default = "noai-ddg";
      engines = {
        # default engine config is stored in .config/zen/default
        # needs `mozlz4a -d .config/zen/default/search.json.mozlz4` to decompress
        ddg.metadata.hidden = true;
        bing.metaData.hidden = true;
        google.metaData.hidden = true;
        perplexity.metaData.hidden = true;

        noai-ddg = {
          name = "Othi's DuckDuckGo";
          urls = [
            { template = "https://noai.duckduckgo.com/?q={searchTerms}"; }
          ];
          definedAliases = [ "@ddg" ];
        };
        mynixos = {
          name = "My NixOS";
          urls = [
            { template = "https://mynixos.com/search?q={searchTerms}"; }
          ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@nx" ];
        };
        nixpkgs = {
          name = "nixpkgs";
          urls = [
            { template = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}"; }
          ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@nix" ];
        };
        home-manager = {
          name = "Home Manager";
          urls = [
            { template = "https://home-manager-options.extranix.com/?query={searchTerms}&release=master"; }
          ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@hm" ];
        };
        github = {
          name = "GitHub Search";
          urls = [
            { template = "https://github.com/search?q={searchTerms}"; }
          ];
          definedAliases = [ "@gh" ];
        };
        youtube = {
          name = "YouTube";
          urls = [
            { template = "https://www.youtube.com/results?search_query={searchTerms}"; }
          ];
          definedAliases = [ "@yt" ];
        };
      };
    };
  };
  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "zen-twilight.desktop" ];
    "x-scheme-handler/http" = [ "zen-twilight.desktop" ];
    "x-scheme-handler/https" = [ "zen-twilight.desktop" ];
    "x-scheme-handler/about" = [ "zen-twilight.desktop" ];
    "x-scheme-handler/unknown" = [ "zen-twilight.desktop" ];
  };

  home.packages = [
    # @see https://github.com/zen-browser/desktop/issues/14889
    pkgs.ffmpeg_4
  ];
}
