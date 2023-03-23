This directory contains dotfiles for configuring and loading [fzf].

# Setup

Install [fzf]:

```shell
brew install fzf
```

The fzf-installed zsh completion and loader scripts are managed via GNU [stow]. Install stow, then run `stow -vv --no-folding --target $HOME fzf/` from the repository root to symlink all fzf-related dotfiles to your home directory.

# Update

Once installed, fzf completion and keybindings file can be updated with:

```shell
$(brew --prefix)/opt/fzf/install --xdg --no-bash --no-fish --no-update-rc --completion --key-bindings
```

# Uninstall

`stow -vv --no-folding --target $HOME --delete nix/`

[fzf]: https://github.com/junegunn/fzf
[stow]: https://www.gnu.org/software/stow/
