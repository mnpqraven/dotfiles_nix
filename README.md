# Installation

- create a new shell with `git`

```nix
nix-shell -p git
```

- run the install script

```nix
curl https://raw.githubusercontent.com/mnpqraven/dotfiles_nix/main/install.sh | sh -
```

- finally rebuild the system and `home-manager`

```nix
sudo nixos-rebuild switch
home-manager switch
```
