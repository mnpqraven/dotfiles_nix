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
  programs.zsh.initContent = lib.mkIf cfg.enable (
    # @see https://github.com/zellij-org/zellij/discussions/2889
    lib.mkOrder 200 ''
      zellij_tab_name_update() {
          if [[ -n $ZELLIJ ]]; then
              local current_dir=$PWD
              if [[ $current_dir == $HOME ]]; then
                  current_dir="~"
              else
                  current_dir=$\{current_dir##*/}
              fi
              command nohup zellij action rename-tab $current_dir >/dev/null 2>&1
          fi
      }
      zellij_tab_name_update
      chpwd_functions+=(zellij_tab_name_update)

      source <(${zellijCmd} setup --generate-completion zsh | sed '/_zellij "$@"/d')
    ''
  );
}
