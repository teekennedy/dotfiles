This directory contains initialization scripts and configuration for direnv.

# Setup

Install direnv:

`brew install direnv`

These dotfiles are managed via GNU [stow]. Install stow, then run `stow -vv --no-folding --dotfiles --target $HOME direnv/` from the repository root to symlink all direnv-related dotfiles to your home directory.

# Usage

## Adding .envrc files

When you cd to a directory, direnv checks that directory (and each parent directory) for a `.envrc` file. This file contains bash code that gets executed into the current shell.

There's many common tools to integrate into the current shell. Direnv has a standard library of functions to make loading them easier. See the [direnv stdlib](https://direnv.net/man/direnv-stdlib.1.html) for a full listing.

# Uninstall

`stow -vv --no-folding --dotfiles --target $HOME --delete direnv/`

[stow]: https://www.gnu.org/software/stow/
