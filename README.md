# Dotfiles by Cyphus

My personal collection of dotfiles. Originally created for Arch, then
completely refactored for macOS. Features:

- zsh:
  - Running off of a personal fork of OMZ with performance fixes for the pyenv
    plugin. See [My PR](https://github.com/robbyrussell/oh-my-zsh/pull/6165)
    for more info.
  - Custom theme based on
    [Bullet Train](https://github.com/caiogondim/bullet-train.zsh).
  - Custom pyenv prompt that only displays when running a locally defined pyenv
    based on the cwd.
  - Aliases / shortcuts:
    - `auth <name>`: Passes the current TOTP code of the given `<name>` from
      your Yubikey to your clipboard.
    - `t <name>`: Attaches to a tmux session of the given `<name>`, or creates
      one if it doesn't already exist.


- tmux:
  - uses `Ctrl+a` as prefix (very common)
  - extended history for panes (100k lines)
  - keeps the current working directory when opening/splitting windows
  - mouse integration (maily used for selecting text for copy-paste)
  - vim-aware smart pane switching (using `Ctrl+[h|j|k|l]`)
  - no status bar. Maybe later I'll customize it to my liking, but for now it's
    just in the way.

- Alacritty
  - Uses [JetBrains Mono](https://www.jetbrains.com/lp/mono/) font.

## Base Installation (macOS)

1. Install base packages through homebrew:

   ```
   brew install \
       # Terminal emulator & font
       alacritty \
       #
       git \
       neovim \
       # useful utilities
       jq \
       tig \
       tree \
       watch \
    ```

1. Clone and initialize submodules:

   ```bash
   git clone git@github.com:cyphus/dotfiles.git
   cd dotfiles
   git submodule update --init --recursive
   ```

1. Run `symlink_dotfiles.sh` to "install" dotfiles by symlinking them from the
   cloned repo to your home directory. Any files that already exist in your
   home directory are first backed up to *dotfile*.bak.  Any files that are
   already symlinks are left alone.

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

## Updating

Pull latest, sync submodules, symlink new dotfiles and/or submodules, and
update neovim:

```bash
git pull
git submodule update --init --recursive
./symlink_dotfiles.sh
nvim -c 'CocUpdateSync|helptags ALL|q'
```

## NeoVim setup

### Adding new plugins

NeoVim plugins are tracked as git submodules, used as a lightweight vendoring
mechanism. They are loaded into nvim using
the native package feature from Vim 8. To add a new vim plugin
as a git submodule, first choose the plugin category from the following list
(or create a new one by adding a new subfolder to
`dotfiles/.local/share/nvim/site/pack`:

- tools (Commands, integrations, new functionalities)
- language (Language specific plugins)
- interface (UI tweaks and colorscheme)

Next, grab the SSH clone url for the plugin's repo and run:

```
git submodule add <repo> dotfiles/.local/share/nvim/site/pack/<category>/<plugin_name>
```

### Updating plugins

```
git submodule foreach git pull origin master
nvim -c 'CocUpdateSync|helptags ALL|q'
```

## Yubikey

### Adding a TOTP 2FA Account

- Setup 2FA on website
- When given QR code to scan with app, find the alternate text representation
  (if available), or use a standard QR code scanner to get the 2FA key.
- Add the key to your Yubikey as an oath code and give it a name:
  `ykman oath accounts add -t <name> <key>`

## Shell Environment

### Adding extra paths to the PATH

Many paths are specific to a given user's environment and therefore should not
be added to the dotfiles version control. Adding machine-specific paths to the
PATH can be done by placing a `.zprofile-paths` file in your home directory
with one path per line. Shell comments are allowed in this file as they are
parsed out when loaded.

## Other helpful utilities

I consider these tools helpful enough to install on all my devices.

```bash
brew install tig tree watch
```

## License:

MIT
