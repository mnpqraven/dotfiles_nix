{ lib, config, ... }:
with lib;
let
  cfg = config.programs.zellij;
  zellijCmd = getExe cfg.package;
in
{
  programs.zellij.enable = true;
  # @see https://github.com/zellij-org/zellij/issues/2316#issuecomment-2318919533
  # @ref https://github.com/nix-community/home-manager/blob/master/modules/programs/zellij.nix
  programs.zsh.initExtra = lib.mkIf cfg.enable (
    lib.mkOrder 200 ''
      source <(${zellijCmd} setup --generate-completion zsh | sed '/_zellij "$@"/d')
    ''
  );
}
