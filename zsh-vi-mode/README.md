This directory contains dotfiles for configuring and loading [zsh-vi-mode], a "better and friendly vi mode plugin for zsh."

# Setup

Install [zsh-vi-mode]:

```bash
brew install zsh-vi-mode
```

The atuin zsh completion and loader scripts are managed via GNU [stow]. Install stow, `cd` to the root directory of the dotfiles repository, then run:

`stow -vv --no-folding --dotfiles --target $HOME atuin`

This will symlink all zsh-vi-mode-related dotfiles to your home directory.

# Update

Once installed, zsh-vi-mode updated with:

```shell
brew upgrade
```

# Uninstall

`stow -vv --no-folding --dotfiles --target $HOME --delete zsh-vi-mode`

[atuin]: https://github.com/ellie/atuin
[zsh-vi-mode]: https://github.com/jeffreytse/zsh-vi-mode
[stow]: https://www.gnu.org/software/stow/
