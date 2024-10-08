This directory contains my nix user-level configuration.

# Setup

This config is managed via GNU [stow]. Install stow, then run `stow -vv --no-folding --dotfiles --target $HOME nix/` from the repository root to symlink all nix-related dotfiles to your home directory.

## Devenv

Add the current user as a trusted user:

```bash
echo "trusted-users = root $USER" | sudo tee -a /etc/nix/nix.conf && sudo pkill nix-daemon
flakes profile install nixpkgs#cachix
cachix use devenv
```

# Uninstall

`stow -vv --no-folding --dotfiles --target $HOME --delete nix/`

[stow]: https://www.gnu.org/software/stow/
