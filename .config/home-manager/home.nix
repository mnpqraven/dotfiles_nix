{ config, pkgs, lib, ... }:

let
  username = "othi";
  HOME = "/home/${username}";
  DHOME = "${HOME}/dotfiles_nix";
  sshKind = "id_ed25519";

  # wrap a package for ime compability
  electronWrap = { name }:
    pkgs.symlinkJoin {
      name = name;
      paths = [ pkgs.${name} ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = lib.strings.concatStrings [
        "wrapProgram $out/bin/"
        name
        " --add-flags \"--enable-wayland-ime\""
      ];
    };
  teams-for-linux = electronWrap { name = "teams-for-linux"; };
  discord = electronWrap { name = "discord"; };

in {
  home.username = username;
  home.homeDirectory = HOME;
  home.sessionVariables = {
    NIXOS_OZONE_WL = 1;
    DHOME = DHOME;
    EWW_BIN = "${HOME}/.nix-profile/bin/eww";
    EWW_CONF = "${DHOME}/.config/eww";
  };
  home.stateVersion = "24.11";
  nixpkgs.config.allowUnfree = true;

  programs = {
    home-manager.enable = true;

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
    helix = {
      enable = true;
      settings = {
        theme = "autumn_night_transparent";
        editor.cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
      languages.language = [{
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
      }];
      themes = {
        autumn_night_transparent = {
          "inherits" = "autumn_night";
          "ui.background" = { };
        };
      };
    };

    zoxide.enable = true;
    zoxide.enableZshIntegration = true;
    starship.enable = true;
    starship.enableZshIntegration = true;

    alacritty = {
      enable = true;
      settings.window.opacity = 0.9;
    };
    zsh = {
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
        update = ''
          cargo install $(cargo install --list | grep -E '^[a-z0-9_-]+
          v[0-9.]+:$' | cut -f1 -d' ')'';
        btw = "macchina";
        homerc = "nvim ${DHOME}/.config/home-manager/home.nix";
        rebuild = "sudo nixos-rebuild switch";
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
    git = {
      enable = true;
      userName = "Othi";
      userEmail = "mnpq.raven@gmail.com";
      aliases = {
        allcommit = "!git add . && git commit -m";
        st = "status";
        tags = "show-ref --abbrev=6 --tags";
        tree =
          "log --graph --abbrev-commit --decorate --date=format:'%d-%m-%Y %H:%M:%S' --format=format:'%C(reverse bold red)%h%C(reset) - %C(white)%ad%C(reset) %C(dim white)(%ar)%C(reset)%C(auto)%d%C(reset)%n'' %C(bold cyan)%s%C(reset) <%C(dim white)%an - %ae%C(reset)>' --all";
      };
      extraConfig = {
        credential = {
          helper = "store";
          "https://github.com".username = "mnpqraven";
        };

        # Sign all commits using ssh key
        commit.gpgsign = true;
        gpg.format = "ssh";
        gpg.ssh.allowedSignersFile = "${HOME}/.ssh/allowed_signers";
        user.signingkey = "${HOME}/.ssh/${sshKind}.pub";
        push = { autoSetupRemote = true; };
      };
    };
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-mozc fcitx5-gtk fcitx5-unikey ];
  };

  home.packages = with pkgs; [
    bacon
    bat
    brave
    btop
    deluge
    discord
    eww
    eza
    fd
    feh
    fzf
    gcc
    git
    git-credential-manager
    go
    hyprshot
    kalker
    keychain
    librewolf
    macchina
    nodejs_20
    nerdfonts
    pnpm
    protobuf
    ripgrep
    rustup
    starship
    teams-for-linux
    wl-clipboard
    wofi
    tofi
    wpaperd
    zellij
    zoxide

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # https://home-manager-options.extranix.com/?query=file&release=release-24.11
    ".ssh/allowed_signers".text =
      "* ${builtins.readFile "${HOME}/.ssh/${sshKind}.pub"}";
    ".config/zellij/config.kdl".source = "${DHOME}/.config/zellij/config.kdl";

    ".config/starship.toml".source = "${DHOME}/.config/starship.toml";
    ".config/macchina" = {
      source = "${DHOME}/.config/macchina";
      recursive = true;
    };
    ".config/fcitx5" = {
      source = "${DHOME}/.config/fcitx5";
      recursive = true;
    };
    ".config/nvim" = {
      source = "${DHOME}/.config/nvim";
      recursive = true;
    };
  };
}
