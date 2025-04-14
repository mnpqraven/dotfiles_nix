{
  inputs,
  pkgs,
  ...
}:
let
  inherit (inputs) username sshKind;
in
{
  home.packages = with pkgs; [ git-credential-manager ];
  programs.git = {
    enable = true;
    userName = "Othi";
    userEmail = "mnpq.raven@gmail.com";
    aliases = {
      allcommit = "!git add . && git commit -m";
      st = "status";
      tags = "show-ref --abbrev=6 --tags";
      tree = "log --graph --abbrev-commit --decorate --date=format:'%d-%m-%Y %H:%M:%S' --format=format:'%C(reverse bold red)%h%C(reset) - %C(white)%ad%C(reset) %C(dim white)(%ar)%C(reset)%C(auto)%d%C(reset)%n'' %C(bold cyan)%s%C(reset) <%C(dim white)%an - %ae%C(reset)>' --all";
    };
    extraConfig = {
      credential = {
        helper = "store";
        "https://github.com".username = "mnpqraven";
      };

      # Sign all commits using ssh key
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "/home/${username}/.ssh/allowed_signers";
      user.signingkey = "/home/${username}/.ssh/${sshKind}.pub";
      push = {
        autoSetupRemote = true;
      };
    };
  };
}
