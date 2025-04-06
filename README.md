# Installation


- Create a new shell with `git`

```bash
nix-shell -p git
ssh-keygen
# run this after ssh-keygen
echo "* $(cat ~/..ssh/id_ed25519.pub)" > ~/.ssh/allowed_signers
```

- clone the repo and build the system with flake.

NOTE: replaces `YOURPLATFORM` with specified hosts (`laptop`)

```bash
git clone --recurse-submodules https://github.com/mnpqraven/dotfiles_nix.git
cd dotfiles_nix
sudo nixos-rebuild switch --flake .#YOURPLATFORM
```

# post-install leftover setup

mozc keymap can only be configured inside gui per following:

```bash
fcitx5-configtool

```

click on mozc settings > configuration tool > configure > keymap style >
customize > import from file > choose `~/dotfiles_nix/.config/mozc/keymap.tsv`
