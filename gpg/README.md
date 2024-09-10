This directory contains my GPG configuration.

# Setup

This config is managed via GNU [stow]. Install stow, then run `stow -vv --no-folding --target $HOME gpg/` from the repository root to symlink all nix-related dotfiles to your home directory.

# Uninstall

`stow -vv --no-folding --target $HOME --delete gpg/`

[stow]: https://www.gnu.org/software/stow/
