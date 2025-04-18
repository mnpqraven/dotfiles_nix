<div align="center">
    <h1>
      Othi's dotfiles (NixOS edition)
    </h1>
    <picture>
      <img alt="Wallpaper" src="./docs/images/main1440.png">
    </picture>
    <span><i>
        <a href="https://x.com/void_ling/status/1855164935141200230">wallpaper</a>
        from the amazing
        <a href="https://x.com/void_ling">@void_ling</a>
    </i></span>
</div>

# Installation

- Generate hardware configuration

```bash
sudo nixos-generate-config # don't need this if you used calamares installer
cp /etc/nixos/hardware-configuration.nix ~/dotfiles_nix/hosts/YOUR_DEVICE
```

- clone the repo and build the system with flake.

NOTE: replaces `YOURPLATFORM` with specified hosts (`laptop | pc | pcremote`)

```bash
nix-shell -p git
git clone --recurse-submodules https://github.com/mnpqraven/dotfiles_nix.git
cd dotfiles_nix
sudo nixos-rebuild switch --flake .#YOURPLATFORM

# run this after you've added the SSH key of the device to github
git remote set-url origin git@github.com:mnpqraven/dotfiles_nix.git
```

# post-install leftover setup

## Git SSH key (+ signing)
```bash
nix-shell -p git
ssh-keygen
# run this after ssh-keygen
echo "* $(cat ~/.ssh/id_ed25519.pub)" > ~/.ssh/allowed_signers
cat ~/.ssh/id_ed25519.pub | wl-copy
```

- go to [Git page](https://github.com/settings/ssh/new) and paste the key


## IM
mozc keymap can only be configured inside gui per following:

```bash
fcitx5-configtool

```

click on mozc settings > configuration tool > configure > keymap style >
customize > import from file > choose `~/dotfiles_nix/.config/mozc/keymap.tsv`

## Languages
TODO: declarative cmd later
```
rustup component add rust-analyzer
```

## NAS mounts
run the script to create a credential file
```
 sudo sh ./scripts/nas-credentials.sh
```

## Hyprpanel (WIP)
Follow the
[instruction](https://hyprpanel.com/help/faq.html#my-weather-is-not-displaying-any-information-or-is-showing-the-wrong-information-what-is-going-on)
to get weather API, then put it in the dotfile directory as `.weatherapi`
```
echo YOUR_WEATHER_API_KEY > .weatherapi
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


# Possible issues

## `nerdfonts` not loading

Try `fc-cache -rf` [(see)](https://github.com/NixOS/nixpkgs/issues/366979)

## Wifi not autoconnecting
if you use `nmtui` and wifi is not automatically connecting after login then
do the following
- have "Automatically connect" and "Available to all users" options
checked.
- If the wifi doesn't automatically connect after boot then delete the
network and re-connect.
- if it still doesn't work then use `nmcli`.

