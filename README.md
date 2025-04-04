# Installation

- create a new shell with `git`

```nix
nix-shell -p git
ssh-keygen
# run this after ssh-keygen
echo "* $(cat ~/..ssh/id_ed25519.pub)" > ~/.ssh/allowed_signers

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

# post-install leftover setup

mozc keymap can only be configured inside gui per following:

```
fcitx5-configtool

```

click on mozc settings > configuration tool > configure > keymap style >
customize > import from file > choose `~/dotfiles_nix/.config/mozc/keymap.tsv`
