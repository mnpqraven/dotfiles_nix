# Standard Installation

- install the default system with calamares
- reboot
- clone the repo and build the system with flake.

NOTE: replaces `HOSTNAME` with specified hosts (`laptop | pc | pcremote`)

```bash
nix-shell -p git
```

Clones the repo

```bash
export HOSTNAME=your_device

git clone --recurse-submodules https://github.com/mnpqraven/dotfiles_nix.git

cp /etc/nixos/hardware-configuration.nix ~/dotfiles_nix/hosts/$HOSTNAME

cd dotfiles_nix
```

Setup Git SSH key (+ signing)

```bash
git remote set-url origin git@github.com:mnpqraven/dotfiles_nix.git
ssh-keygen
# run this after ssh-keygen
echo "* $(cat ~/.ssh/id_ed25519.pub)" > ~/.ssh/allowed_signers
cat ~/.ssh/id_ed25519.pub | wl-copy
```

Go to [Git page](https://github.com/settings/ssh/new) and paste the key

  
Builds the system

```bash
nixos-rebuild switch --flake .#$HOSTNAME --sudo
```

# Post-install leftover setup

## IM

mozc keymap can only be configured inside gui per following:

```bash
fcitx5-configtool
```

click on mozc settings > configuration tool > configure > keymap style >
customize > import from file > choose `~/dotfiles_nix/.config/mozc/keymap.tsv`

## Languages

```bash
rustup component add rust-analyzer
```

## Credentials

Follow the
[instruction](https://hyprpanel.com/help/faq.html#my-weather-is-not-displaying-any-information-or-is-showing-the-wrong-information-what-is-going-on)
to get weather API, then run the scripts to create credential files

```bash
sudo sh ./scripts/nas-credentials.sh
sh ./scripts/weather-credentials.sh
```

```bash
```

## Networking

If the device uses Wifi, then connect to a wifi by using `nmcli` or `nmtui`

```bash
# rescan the device list
nmcli device wifi rescan
# list
nmcli device wifi list
# scan for devices
nmcli device list connect "name" password "password"
```
