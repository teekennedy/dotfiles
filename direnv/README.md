This directory contains initialization scripts and configuration for direnv.

# Setup

Install direnv:

`brew install direnv`

These dotfiles are managed via GNU [stow]. Install stow, then run `stow -vv --no-folding --target $HOME direnv/` from the repository root to symlink all direnv-related dotfiles to your home directory.

# Uninstall

`stow -vv --no-folding --target $HOME --delete direnv/`

[stow]: https://www.gnu.org/software/stow/
