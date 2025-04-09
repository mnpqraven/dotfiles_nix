_: {
  programs.helix = {
    enable = true;
    languages.language = [
      # {
      #   name = "nix";
      #   auto-format = true;
      #   formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
      # }
    ];
  };
}
