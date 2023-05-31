This directory contains dotfiles for configuring and loading [atuin], a "magical shell history."

# Setup

Install [atuin]:

```shell
brew install atuin
```

The atuin zsh completion and loader scripts are managed via GNU [stow]. Install stow, then run `stow -vv --no-folding --target $HOME fzf/` from the repository root to symlink all atuin-related dotfiles to your home directory.

# Update

Once installed, atuin updated with:

```shell
brew upgrade
```

# Uninstall

`stow -vv --no-folding --target $HOME --delete atuin/`

[atuin]: https://github.com/ellie/atuin
[stow]: https://www.gnu.org/software/stow/
