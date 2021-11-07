# Dotfiles by Cyphus

My personal collection of dotfiles. Originally created for Arch, then
completely refactored for macOS. Features:

- macOS settings (see setup_macos_defaults.sh for full list):
  - Map caps lock key to esc.
  - Sets host name interactively (skippable).
  - Speeds up or disables many animations.
  - Speeds up key repeat rate beyond the range of what's settable via GUI.
  - Turns off autocorrect, auto quote conversion, and auto emdash conversion.
  - Enables tap to click, fixes scrolling direction.
  - Sets sensible defaults for:
    - Finder
    - Dock
    - Safari
    - Spotlight
    - Activity Monitor
    - Disk Utility
    - QuickTime Player
    - Photos

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

1. If you haven't already, setup an SSH key for use with GitHub. You'll need it
   to initialize submodules for this repo.

1. Install Homebrew and some packages used as dependencies for this repo:

   ```
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   [ -n "$ZSH_VERSION" ] && setopt local_options interactive_comments
   # The above line allows comments like this in interactive sessions
   brew install \
       alacritty `# Efficient terminal emulator` \
       colordiff `# Colorized diff output` \
       git `# Comes with macOS but brew's is newer` \
       neovim `# Editor` \
       tmux `# Terminal multiplexer` \
       ykman `# YubiKey manager`
   ```

1. Clone and initialize submodules:

   ```bash
   git clone git@github.com:cyphus/dotfiles.git
   cd dotfiles
   git submodule update --init --recursive
   ```

1. If you'd like to set macOS defaults, please READ through
   `setup_macos_defaults.sh` to make sure you agree with the settings, then
   run it:

   ```
   ./setup_macos_defaults.sh
   ```

   It will prompt you for your password (for sudo), and for a new hostname for
   the computer (leave blank to skip setting hostname). Once the script is done,
   restart to apply all changes.

1. Run `symlink_dotfiles.sh` to "install" dotfiles by symlinking them from the
   cloned repo to your home directory. Any files that already exist in your
   home directory are first backed up to *dotfile*.bak.  Any files that are
   already symlinks are left alone.

   ```console
   $ ./symlink_dotfiles.sh
   [SKP] /Users/tkennedy/.alacritty.yml is already symlinked. Skipping.
   [SKP] /Users/tkennedy/.config/nvim/after/filetype.vim is already symlinked. Skipping.
   [SKP] /Users/tkennedy/.config/nvim/after/ftplugin/c.vim is already symlinked. Skipping.
   [SKP] /Users/tkennedy/.config/nvim/after/ftplugin/ruby.vim is already symlinked. Skipping.
   [SKP] /Users/tkennedy/.config/nvim/after/ftplugin/tracwiki.vim is already symlinked. Skipping.
   ...  (snip) ...
   [SKP] /Users/tkennedy/.local/share/nvim/site/pack/tools/start/fugitive is already symlinked. Skipping.
   [SKP] /Users/tkennedy/.local/share/nvim/site/pack/tools/start/visual-star-search is already symlinked. Skipping.
   [BAK] Backing up /Users/tkennedy/.oh-my-zsh to /Users/tkennedy/.oh-my-zsh.2021-06-10T13_33_43.bak
   [SYM] Symlinking /Users/tkennedy/.oh-my-zsh to /Users/tkennedy/projects/dotfiles/dotfiles/.oh-my-zsh
   [SKP] /Users/tkennedy/.tmux.conf is already symlinked. Skipping.
   ```

## Updating Dotfiles

Pull latest, sync submodules, symlink new dotfiles and/or submodules, and
update neovim:

```bash
git pull
git submodule update --init --recursive
./symlink_dotfiles.sh
nvim -c 'CocUpdateSync|helptags ALL|q'
```

## Submodules

### Adding

`git submodule add <SSH repository url> <path>`

### Updating

`git submodule update --recursive --remote`

### Removing

```
git submodule deinit -f -- a/submodule    
rm -rf .git/modules/a/submodule
git rm -f a/submodule
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
