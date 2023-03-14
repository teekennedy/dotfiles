# Alacritty setup

[Alacritty](https://alacritty.org/) is a modern, efficient terminal emulator. I
switched to it after having issues with input lag on iTerm2 and have had a
seamless experience.

## Setup

To install, make sure you've ran `symlink_dotfiles.sh` and then install
Alacritty and its font.

```bash
brew install alacritty
```

Note: at the time of writing, homebrew cask does not have the font families
referenced by [Alacritty's config](.config/alacritty/alacritty.yml). Instead,
these fonts need to be installed from a cloned repo:

```bash
git clone --filter=blob:none --sparse git@github.com:ryanoasis/nerd-fonts
cd nerd-fonts
git sparse-checkout add patched-fonts/JetBrainsMono
./install.sh JetBrainsMono
```

## Configuration

Alacritty is configured via a single yaml file, `~/.alacritty.yml`. I left most
of the config options at their defaults, only setting the font (JetBrains Mono)
and the colorscheme (Gruvbox Dark, to match NeoVim). 
