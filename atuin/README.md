This directory contains dotfiles for configuring and loading [atuin], a "magical shell history."

# Setup

Install [atuin]:

```shell
brew install atuin
```

Import your existing shell history into atuin's sqlite database:

```shell
atuin import auto
```

The atuin zsh completion and loader scripts are managed via GNU [stow]. Install stow, `cd` to the root directory of the dotfiles repository, then run:

`stow -vv --no-folding --dotfiles --target $HOME atuin/`

This will symlink all atuin-related dotfiles to your home directory.

# Update

Once installed, atuin updated with:

```shell
brew upgrade
```

# Uninstall

`stow -vv --no-folding --dotfiles --target $HOME --delete atuin/`

[atuin]: https://github.com/ellie/atuin
[stow]: https://www.gnu.org/software/stow/
