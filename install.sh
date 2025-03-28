cd $HOME

# recursively clone with submodules
git clone --recurse-submodules https://github.com/mnpqraven/dotfiles_nix.git
cd dotfiles_nix
git remote set-url origin git@github.com:mnpqraven/dotfiles_nix.git

# system conf
sudo cp configuration.nix /etc/nixos

# creates ssh key
ssh-keygen

# symlink
ln -s ~/dotfiles_nix/.config/home-manager ~/.config/home-manager
