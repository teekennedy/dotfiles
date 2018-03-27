# Dotfiles by Cyphus

My personal collection of dotfiles. Originally optimized for Arch, now
optimized for macOS. Features:

- zsh:
  - Running off of a personal fork of OMZ with performance fixes for the pyenv
    plugin. See [My PR](https://github.com/robbyrussell/oh-my-zsh/pull/6165)
    for more info.
  - Custom theme based on
    [Bullet Train](https://github.com/caiogondim/bullet-train.zsh).
  - Custom pyenv prompt that only displays when running a locally defined pyenv
    based on the cwd.

- tmux:
  - uses `Ctrl+a` as prefix (very common)
  - extended history for panes
  - keeps the current directory when opening/splitting windows
  - mouse integration (maily used for selecting text for copy-paste)
  - vim-aware smart pane switching (using `Ctrl+[h|j|k|l]`)


## Base Installation (macOS)

1. Install base packages required for all dotfiles to function:

```bash
brew update
brew install \
        git \
        macvim --with-override-system-vim \
        tmux \
        zsh \
        ;
```

1. Clone the repo and checkout submodules:

```bash
git clone git@github.com:cyphus/dotfiles.git
cd dotfiles
git submodule update --init --recursive
```

1. Symlink dotfiles from the cloned repo to your home directory. Any files that
   already exist in your home directory are first backed up to *dotfile*.bak.
   Any files that are already symlinks are left alone.

```console
$ ./symlink_dotfiles.sh
Syminking /Users/cyphus/.gitconfig to /Users/cyphus/projects/dotfiles/.gitconfig
Backing up /Users/cyphus/.gitignore_global to /Users/cyphus/.gitignore_global.bak
Symlinking /Users/cyphus/.gitignore_global to /Users/cyphus/projects/dotfiles/.gitignore_global
Symlinking /Users/cyphus/.tmux.conf to /Users/cyphus/projects/dotfiles/.tmux.conf
Symlinking /Users/cyphus/.vim to /Users/cyphus/projects/dotfiles/.vim
Symlinking /Users/cyphus/.vimrc to /Users/cyphus/projects/dotfiles/.vimrc
Symlinking /Users/cyphus/.zshrc to /Users/cyphus/projects/dotfiles/.zshrc
```

## Other helpful utilities

I consider these tools helpful enough to install on all my devices.

```bash
brew install tig watch
```

## License:

MIT
