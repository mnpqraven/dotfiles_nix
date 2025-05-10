# WIP

- Generate hardware configuration

```bash
export YOUR_DEVICE = your_device
sudo nixos-generate-config # don't need this if you used calamares installer
cp /etc/nixos/hardware-configuration.nix ~/dotfiles_nix/hosts/YOUR_DEVICE
```
