{
  config,
  inputs,
  pkgs,
  ...
}:
let
  inherit (inputs) sshKind username;
in
{
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "common-aliases"
        "vi-mode"
      ];
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
      fm = "clifm";
      mz = "rmpc";
      # TODO: dyn
      rc = "nvim /home/${username}/dotfiles_nix/flake.nix";
      rebuild = "sudo nixos-rebuild switch --flake .#${inputs.device} --show-trace -L -v";
      trybuild = "sudo nixos-rebuild test --flake .#${inputs.device} --show-trace -L -v";
      upgrade = "sudo nixos-rebuild switch --flake .#${inputs.device} --show-trace -L -v --recreate-lock-file";
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
      qmkf = "git checkout master && git fetch upstream && git pull upstream master && git push origin master";
    };
    history.size = 10000;
  };
}
