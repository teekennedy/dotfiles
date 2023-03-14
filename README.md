# Terrance Kennedy's Dotfiles

My personal collection of dotfiles. Originally created for Arch, then
completely refactored for macOS. Features:

- **zsh**
  - Relatively minimal setup with autocompletion and colorized output where
    available.
  - Prompt from [Powerlevel10k].
  - Fuzzy finder ([fzf]) integration.
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
   home directory are first backed up to *dotfile*.bak.  Any files that are
   already symlinks are left alone.

   ```console
   ./symlink_dotfiles.sh
   ```

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
    fzf        `# Command line fuzzy finder`
    git        `# Comes with macOS but brew's is newer` \
    git-delta  `# Syntax highlighting pager for git, diff, and grep output` \
    jq         `# Json query tool` \
    mas        `# Mac App Store CLI` \
    tig        `# Git repo browser` \
    tmux       `# Terminal multiplexer` \
    tree       `# Pretty print directory contents` \
    watch      `# Run commands repeatedly`

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
## Alacritty setup

[Alacritty](https://alacritty.org/) is a modern, efficient terminal emulator. I
switched to it after having issues with input lag on iTerm2 and have had a
seamless experience.

Alacritty is configured via a single yaml file, `~/.alacritty.yml`. I left most
of the config options at their defaults, only setting the font (JetBrains Mono)
and the colorscheme (Gruvbox Dark, to match NeoVim). To install, make sure
you've ran `symlink_dotfiles.sh` and then install Alacritty and its font.

```bash
brew install alacritty
```

Note: at the time of writing, homebrew cask does not have the font families
referenced by Alacritty's config. Instead, these fonts need to be installed
from a cloned repo:

```bash
git clone --filter=blob:none --sparse git@github.com:ryanoasis/nerd-fonts
cd nerd-fonts
git sparse-checkout add patched-fonts/JetBrainsMono
./install.sh JetBrainsMono
```

If you want to enable support for italics and 24 bit color in alacritty and
tmux, you'll have to add the terminal info files for both:

```bash
pushd $(mktemp -d)
# Download and unpack latest terminal descriptions from ncurses site
curl -fSsLO https://invisible-island.net/datafiles/current/terminfo.src.gz
gunzip terminfo.src.gz
# Compile terminfos full path to ensure this is the version of tic shipped with macOS
/usr/bin/tic -xe tmux-256color,alacritty terminfo.src
popd
```

To confirm that alacritty has successfully picked up its terminfo, launch a new
Alacritty window and run `echo $TERM`. It should output `alacritty-direct`. If
it doesn't, this gist on installing term

## Zsh setup

Install zsh dependencies [Powerlevel10k] and [fzf] with:

```bash
brew install romkatv/powerlevel10k/powerlevel10k fzf
```

Then install fzf's zsh integration with:

```bash
$(brew --prefix)/opt/fzf/install
```

That's it! You won't see the changes until you either start a new shell or run
`source ~/.zshrc` in the current one.

## NeoVim setup

[NeoVim](https://neovim.io/) is a modern fork of Vim. I have it configured as a
pretty full fledged IDE thanks to a combination of
[coc.nvim](https://github.com/neoclide/coc.nvim), [Asynchronous Lint
Engine](https://github.com/dense-analysis/ale), and a healthy amount of
language-specific plugins and config.

Setting up NeoVim requires only NeoVim itself and a recent version of node,
which is required by coc. I use [fnm](https://github.com/Schniz/fnm) for
managing my node runtimes, so setup looks like this:

```bash
brew install fnm neovim
eval $(fnm env)
fnm install --lts
nvim -c 'CocUpdateSync | TSUpdate all | helptags ALL | q'
```

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

Next, grab the https clone url for the plugin's repo and run:

```bash
git submodule add <repo> dotfiles/.local/share/nvim/site/pack/<category>/start/<plugin_name>
```

### Updating plugins

```bash
git submodule update --recursive --remote
nvim -c 'CocUpdateSync | TSUpdate all | helptags ALL | q'
```

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

Applying AutoConfig requires adding files to the Firefox installation directory. Run the following
commands from the dotfiles repo root to symlink AutoConfig files to where Firefox expects them:

```bash
if [ "$(uname -s)" = "Darwin" ]; then
  FF_BASE_DIR="$(osascript -e 'POSIX path of (path to application "Firefox")')/Contents/Resources"
else
  FF_BASE_DIR="$(which firefox)"
fi

stow -vv --no-folding --target "$FF_BASE_DIR" firefox
```

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

#### U2F keys and ssh-agent

MacOS's default ssh-agent doesn't support ed25519-sk or ecdsa-sk keys. While
adding U2F keys to your ssh-agent doesn't offer much in terms of convenience
(you still have to tap your YubiKey on every use), having the agent error out
every time you try to use a U2F key is quite annoying.

If you want to use your U2F SSH keys with the ssh-agent, you'll need to use a
newer version of ssh-agent from homebrew. MacOS versions with System Integrity
Protection do not make this easy, as the default ssh-agent is a system-level
service that cannot be disabled or overwritten since it lives under the
protected `/System` directory.

To use homebrew's ssh-agent, one has to resort to the somewhat hacky solution
of starting homebrew's ssh-agent with a new unix socket path, and then forcibly
symlink the system-provided unix socket to the path used by homebrew. Roughly
equivalent to running the following at login:

```bash
# Create a temporary path for homebrew's socket
HOMEBREW_SSH_AUTH_SOCK=$(mktemp -dt ssh-agent)/auth-sock

# Overwrite the system-generated socket with a symlink to homebrew's
sudo ln -sf $HOMEBREW_SSH_AUTH_SOCK $SSH_AUTH_SOCK

# Start homebrew's ssh-agent using the new path
eval "$(ssh-agent -a $HOMEBREW_SSH_AUTH_SOCK)"
```

To ensure this works across all applications that use ssh-agent, it's best to
run these steps before login, via your own launch agent. I've made a script to
setup such an agent [./setup_homebrew_ssh_agent.sh].

See [Kirill Kuznetsov's post] for a detailed background on the motivation
behind setting up such a launch agent.

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
[fzf]: https://github.com/junegunn/fzf
[Kirill Kuznetsov's post]: https://evilmartians.com/chronicles/stick-with-security-yubikey-ssh-gnupg-macos#making-things-stick
[Powerlevel10k]: https://github.com/romkatv/powerlevel10k
[location that depends on OS]: https://code.visualstudio.com/docs/getstarted/settings#_settings-file-locations
