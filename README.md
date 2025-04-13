# Installation

- Generate hardware configuration

```bash
sudo nixos-generate-config
cp /etc/nixos/hardware-configuration.nix ~/dotfiles_nix/hosts/YOUR_DEVICE
```


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

# run this after you've added the SSH key of the device to github
git remote set-url origin git@github.com:mnpqraven/dotfiles_nix.git
```

# post-install leftover setup

- IM
mozc keymap can only be configured inside gui per following:

```bash
fcitx5-configtool

```

click on mozc settings > configuration tool > configure > keymap style >
customize > import from file > choose `~/dotfiles_nix/.config/mozc/keymap.tsv`

# Languages
TODO: declarative cmd later
```
rustup component add rust-analyzer
```

# Hyprpanel
Follow the
[instruction](https://hyprpanel.com/help/faq.html#my-weather-is-not-displaying-any-information-or-is-showing-the-wrong-information-what-is-going-on)
to get weather API, then put it in the dotfile directory as `.weatherapi`
```
echo YOUR_WEATHER_API_KEY > .weatherapi
```

# Networking
If the device uses Wifi, then connect to a wifi by using `nmcli` or `nmtui`
```bash
# rescan the device list
nmcli device wifi rescan
# list
nmcli device wifi list
# scan for devices
nmcli device list connect "name" password "password"
```

#### NOTE: if you use `nmtui` then remember to have "Automatically connect" and
"Available to all users" options checked. If the wifi doesn't automatically
connect after boot then delete the network and re-connect, if it still doesn't
work then use `nmcli`

### Possible issues

#### nerdfonts not loading

Try `fc-cache -rf` [(see)](https://github.com/NixOS/nixpkgs/issues/366979)
