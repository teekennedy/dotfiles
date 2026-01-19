# Terrance Kennedy's Dotfiles

My personal collection of dotfiles. Originally created for Arch, then
completely refactored for macOS. Features:

- **zsh**

  - Relatively minimal setup with autocompletion and colorized output where
    available.
  - Prompt from [Starship].
  - Shell history via [atuin].
  - Aliases / shortcuts:
    - `auth <name>`: Passes the current TOTP code of the given `<name>` from
      your Yubikey to your clipboard.
    - `cat` aliased to the syntax-highlighting [bat]. Bat is also used as the
      output pager for the aws-cli.
    - `diff`: aliased to colordiff, if available.
    - `man`: aliased to `batman` from [bat-extras].
    - `t <name>`: Attaches to a tmux session of the given `<name>`, or creates
      one if it doesn't already exist.
    - `vim`: aliased to neovim, if available.

- **tmux**

  - uses `Ctrl+a` as prefix (very common)
  - creates non-login shells by default (faster and doesn't mess up PATH)
  - extended history for panes (100k lines)
  - keeps the current working directory when opening/splitting windows
  - mouse integration (maily used for selecting text for copy-paste)
  - vim-aware smart pane switching (using `Ctrl+[h|j|k|l]`)
  - no status bar. Maybe later I'll customize it to my liking, but for now it's
    just in the way.

- **Alacritty**

  - Uses [JetBrains Mono](https://www.jetbrains.com/lp/mono/) font.
  - Has great defaults, doesn't need much customization.

- **MacOS Setup** to sync all my mac settings across devices:
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
    - Bear (if installed)

## Base Installation (macOS)

1. Install Homebrew if you haven't already:

   ```bash
   xcode-select --install
   sudo xcodebuild -license accept
   ```

1. Install dependencies for dotfiles management:

   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
   brew install git stow
   ```

1. Clone this repo and initialize submodules:

   ```bash
   # Clone using SSH url:
   git clone git@github.com:teekennedy/dotfiles.git
   # Or https url if you don't have SSH access setup yet:
   #   git clone https://github.com/teekennedy/dotfiles.git
   cd dotfiles
   git submodule update --init --recursive
   ```

1. If you'd like to set macOS defaults, please READ through
   `setup_macos_defaults.sh` to make sure you agree with the settings, then
   run it:

   ```bash
   ./setup_macos_defaults.sh
   ```

   It will prompt you for your password (for sudo), and for a new hostname for
   the computer (leave blank to skip setting hostname). Once the script is done,
   restart to apply all changes.

1. Run `symlink_dotfiles.sh` to "install" dotfiles by symlinking them from the
   cloned repo to your home directory. Any files that already exist in your
   home directory are first backed up to _dotfile_.bak. Any files that are
   already symlinks are left alone.

   ```console
   ./symlink_dotfiles.sh
   ```

## Nix

Using [nix], [nix-darwin], and [home-manager], configuration and tooling can be declaratively configured.

### Installation

1. Install nix using the [determinate systems installer](https://github.com/DeterminateSystems/nix-installer#determinate-nix-installer):

   ```shell
   curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
   sh -s -- install
   ```

1. Install [nix-darwin] using the flake in this repo:

   ```shell
   nix run nix-darwin -- switch --flake .
   ```

This will install nix-darwin, home-manager, and the rest of my dotfiles and tooling.
You may need to start a new shell for the settings to fully take effect.

### Applying changes

After making changes to the nix-darwin configuration, run `darwin-rebuild switch --flake .` to apply.

## Updating Dotfiles

Pull latest, sync submodules, symlink new dotfiles and/or submodules, and
update neovim using `update_dotfiles.sh`.

## Submodules

### Adding

`git submodule add <HTTPS repository url> <path>`

### Updating

`git submodule update --recursive --remote`

### Removing

```bash
git submodule deinit -f -- a/submodule
rm -rf .git/modules/a/submodule
git rm -f a/submodule
```

## Recommended extras

In addition to the base installation, here's some other recommended utilities
and applications I use every day:

```bash
# CLI utilities
brew install \
    bat        `# Cat clone with syntax highlighting support` \
    bat-extras `# Bat integration with other utilities` \
    colordiff  `# Colorized diff tool` \
    coreutils  `# GNU file, shell, text utilities (I use gls for colorized ls output)` \
    git        `# Comes with macOS but brew's is newer` \
    git-delta  `# Syntax highlighting pager for git, diff, and grep output` \
    jq         `# Json query tool` \
    mas        `# Mac App Store CLI` \
    tig        `# Git repo browser` \
    tmux       `# Terminal multiplexer` \
    tree       `# Pretty print directory contents` \
    watch      `# Run commands repeatedly`

# JetBrains Mono Nerd Font (Used by my Alacritty config):
brew tap homebrew/cask-fonts
brew install font-jetbrains-mono-nerd-font

# If you get an error: 'command not found: #' when running the above, either
# remove the inline comments or run 'setopt interactive_comments' to fix.

# Apps
brew install --cask \
    fantastical `# Calendar` \
    keepassxc   `# Password manager` \
    notunes     `# Prevent Play/Pause button from launching Apple Music`

mas install \
    904280696  `# Things (todos)` \
    1091189122 `# Bear (notes)` \
    1439431081 `# Intermission (give your eyes a break)`
```

## Zsh setup

Install zsh dependencies [Starship] and [atuin] with:

```bash
brew install starship atuin
```

That's it! You won't see the changes until you either start a new shell or run
`source ~/.zshrc` in the current one.

## NeoVim setup

[NeoVim](https://neovim.io/) is a modern fork of Vim.
I have it configured using [AstroNvim](https://github.com/AstroNvim/AstroNvim),
which provides a great default setup. Unlike [LunarVim](https://www.lunarvim.org/),
AstroNvim does not hide configuration behind an abstraction layer.

Setting up AstroNvim requires NeoVim itself,
Nerd Fonts (installed as a dependency to Alacritty),
and a terminal with true color support (Alacritty).

To install, see the latest [installation instructions for AstroNvim](https://astronvim.com/#%EF%B8%8F-installation) on their website.

## VS Code Setup

VS Code's settings.json has a [location that depends on OS]. I develop on macOS and Linux, so to
support both, I have the settings.json in my dotfiles repo symlinked to the default Linux location,
`~/.config/Code/User/settings.json`. For macOS I have the extra one-time setup of sylinking the
default macOS directory to the default Linux directory:

```bash
ln -sf $HOME/.config/Code/User/settings.json $HOME/Library/Application\ Support/Code/User/settings.json
```

## Firefox

Firefox Sync will keep some settings in sync, but many config options have to be set on a
per-install basis. I use Firefox's
[AutoConfig](https://support.mozilla.org/en-US/kb/customizing-firefox-using-autoconfig) setup to
centralize management of configuration options across my devices.

My AutoConfig settings disable the built-in Pocket extension (sigh..), work around a memory leak by
disabling Accessibility Services (see [this
bug](https://bugzilla.mozilla.org/show_bug.cgi?id=1726887) for context), and disable all telemetry.

### Setup

Install Firefox if you haven't already:

```bash
brew install --cask firefox
```

Applying AutoConfig requires adding files to the Firefox installation directory.
The `symlink_dotfiles.sh` script automatically handles this.

## YubiKey (U2F) setup

I use a YubiKey for convenient 2FA for just about anything that supports it. It
can be managed via the `ykman` CLI:

```bash
brew install ykman
```

If this is the first time using your YubiKey, I recommend turning off OTP to
prevent long strings of letters being typed when you accidentally touch it. OTP
is rarely used and the services that support it have other options anyway.

```console
$ ykman config usb --disable OTP
Disable OTP.
This will cause the YubiKey to reboot.
Configure USB? [y/N]: y
```

### Using YubiKey for SSH

YubiKeys support ecdsa-sk and ed25519-sk SSH keys. Like other SSH keys, these
keys are asymmetric (have public and private components), but in this case the
private key is split into a resident key and a handle to the hardware token,
thus requiring it to be activated for every SSH operation.

#### Adding SSH keys

To add a new SSH key, first try to generate a more secure ed25519-sk key:

`ssh-keygen -t ed25519-sk`

If that doesn't work, it's likely that your YubiKey doesn't support ed25519-sk.
Fall back to ecdsa-sk:

`ssh-keygen -t ecdsa-sk`

Now every time you use the key, you'll be prompted to confirm user presence by
tapping your YubiKey.

### Adding a TOTP 2FA Account

- Setup 2FA on website
- When given QR code to scan with app, find and copy the alternate text
  representation of the QR code.
- Add the key to your Yubikey as an oath code and give it a name:
  `ykman oath accounts add -t <name> <key>`

## License:

MIT

[bat]: https://github.com/sharkdp/bat
[bat-extras]: https://github.com/eth-p/bat-extras
[atuin]: https://github.com/ellie/atuin
[Kirill Kuznetsov's post]: https://evilmartians.com/chronicles/stick-with-security-yubikey-ssh-gnupg-macos#making-things-stick
[Starship]: https://starship.rs
[location that depends on OS]: https://code.visualstudio.com/docs/getstarted/settings#_settings-file-locations
[nix-darwin]: https://github.com/LnL7/nix-darwin
[nix]: https://nixos.org/
[home-manager]: https://github.com/nix-community/home-manager
