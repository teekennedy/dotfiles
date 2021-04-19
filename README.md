# Dotfiles by Cyphus

My personal collection of dotfiles. Originally optimized for Arch, then
completely refactored for macOS. Features:

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
  - extended history for panes (100k lines)
  - keeps the current working directory when opening/splitting windows
  - mouse integration (maily used for selecting text for copy-paste)
  - vim-aware smart pane switching (using `Ctrl+[h|j|k|l]`)
  - no status bar. Maybe later I'll customize it to my liking, but for now it's
    just in the way.
  - does _not_ use
    [reattach-to-user-namespace](https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard/)
    as it is not needed for tmux 2.6+ (see
    [#66](https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard/issues/66)).

- iTerm2
  - Uses [JetBrains Mono](https://www.jetbrains.com/lp/mono/) font.

## Base Installation (macOS)

1. Install [Xcode](https://itunes.apple.com/us/app/xcode/id497799835?mt=12)
   from the Mac App Store. While most utilities under Homebrew only require the
   Xcode command line tools, macvim in particular needs a full Xcode
   installation.

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
```

## iTerm2 setup

If you want your iTerm2 terminal to look like mine, follow these steps:

 * Install [JetBrains Mono](https://www.jetbrains.com/lp/mono/) font:
   ```
   brew tap homebrew/cask-fonts
   brew install font-jetbrains-mono
   ```
 * Go to the *Profiles* tab of the iTerm2 prefernces page. Under the *Text*
   section of your currently activated profile, make sure that:
   * *Use built-in Powerline glyphs* is ✅
   * Change the font to JetBrains Mono installed earlier, and make sure both
     *Use ligatures* and *Anti-aliased* are ✅

## Adding extra paths to the PATH

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
