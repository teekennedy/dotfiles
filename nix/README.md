This directory contains my nix user-level configuration.

# Setup

This config is managed via GNU [stow]. Install stow, then run `stow -vv --no-folding --target $HOME nix/` from the repository root to symlink all nix-related dotfiles to your home directory.

# Uninstall

`stow -vv --no-folding --target $HOME --delete nix/`

[stow]: https://www.gnu.org/software/stow/
