# Vivid

[Vivid](https://github.com/sharkdp/vivid) themes the output of various tools that list files in the terminal.
It does this by generating the contents of the `LS_COLORS` environment variable.

## Installation

There is no need to install `vivid` directly - the colorscheme is pre-generated to use GruvBox Dark.

The default macOS provided `ls` command is not `LS_COLORS` aware. If you install `coreutils`, the script will use the GNU version of ls instead.

```console
brew install coreutils
```

## Configuration

The configuration files contained in this directory can be installed with [GNU stow].
Make sure you have stow installed (`brew install stow`) then run:

```
cd "$(git rev-parse --show-toplevel)" # cd to dotfiles repo root
stow -v --no-folding --restow --dotfiles --target "$HOME" vivid
```
