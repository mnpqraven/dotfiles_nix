{
  config,
  osConfig,
  ...
}:
let
  device = osConfig.networking.hostName;
  sshKind = "id_ed25519";
in
{
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    autosuggestion = {
      enable = true;
      highlight = "fg=#c099ff,underline";
    };
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "common-aliases"
        "vi-mode"
      ];
    };
    initContent = ''
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

      tree = "erd";
      cl = "clear";
      rf = "clear && macchina";
      btw = "macchina";
      fm = "yazi";
      mz = "rmpc";
      # FIXME: dyn
      rc = "$EDITOR ${config.home.homeDirectory}/dotfiles_nix/flake.nix";
      rebuild = "sudo nixos-rebuild switch --flake .#${device} --show-trace -L -v";
      trybuild = "sudo nixos-rebuild test --flake .#${device} --show-trace -L -v";
      upgrade = "sudo nixos-rebuild switch --flake .#${device} --show-trace -L -v --recreate-lock-file";
      nix-gc = "nix-collect-garbage -d";
      zm = "zellij -l compact";
      zms = "zellij -l welcome";
      v = "nvim";
      cr = "cargo run --";
      gpl = "git pull --recurse-submodules";
      gt = "git tree";
      gg = "lazygit";
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
