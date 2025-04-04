{ config, inputs, pkgs, ... }:
let
  DHOME = inputs.rootPath;
  inherit (inputs) sshKind username;
in {

  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "common-aliases" "vi-mode" ];
    };
    initExtra = ''
      bindkey '^o' autosuggest-execute
      bindkey '^b' backward-word
      bindkey '^q' backward-delete-word
      bindkey '^[[3~' delete-char
      bindkey '^w' forward-word
      bindkey -M vicmd '^[[3~' forward-char

      eval $(keychain --eval --quiet --nogui ${sshKind})
      macchina
    '';
    shellAliases = {
      # built-in overrides
      ls = "eza";
      cat = "bat";

      cl = "clear";
      rf = "clear && macchina";
      btw = "macchina";
      # TODO: dyn
      rc = "nvim /home/${username}/dotfiles_nix/flake.nix";
      rebuild = "sudo nixos-rebuild switch --flake .#laptop --show-trace -L -v";
      trybuild = "sudo nixos-rebuild test --flake .#laptop --show-trace -L -v";
      nix-gc = "nix-collect-garbage -d";
      zm = "zellij";
      v = "nvim";
      cr = "cargo run --";
      gt = "git tree";
      gac = "git allcommit";
      grst = "git reset --soft";
      gRST = "git reset --hard && git clean -fd";
      gmnc = "git merge --no-commit";
      gcom = "git checkout main";
      qmkf =
        "git checkout master && git fetch upstream && git pull upstream master && git push origin master";

      # .rc
      vrc = "$EDITOR ${DHOME}/.config/nvim";
      zrc = "$EDITOR ${DHOME}/.zshrc";
      zenv = "$EDITOR ${DHOME}/.zshenv";
      tmrc = "$EDITOR ${DHOME}/.tmux.conf";
    };
    history.size = 10000;
  };
}
