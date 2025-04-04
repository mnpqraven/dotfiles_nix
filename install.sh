cd $HOME

# recursively clone with submodules
git clone --recurse-submodules https://github.com/mnpqraven/dotfiles_nix.git
cd dotfiles_nix
git remote set-url origin git@github.com:mnpqraven/dotfiles_nix.git

# system conf
sudo cp system_confs/configuration.nix /etc/nixos
sudo cp system_confs/othi.nix /etc/nixos
sudo cp system_confs/flake.nix /etc/nixos

# creates ssh key
ssh-keygen

# symlink
ln -s ~/dotfiles_nix/.config/home-manager ~/.config/home-manager
mkdir -p ~/.config/hypr
# TODO: transform to iterator
# TODO: add following links:
# ags mozc
ln -sf ~/dotfiles_nix/.config/hypr/hyprland.conf ~/.config/hypr
ln -sf ~/dotfiles_nix/.config/wpaperd  ~/.config/wpaperd
ln -sf ~/dotfiles_nix/.config/mozc  ~/.config
