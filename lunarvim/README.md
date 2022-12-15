# LunarVim

[LunarVim] is NeoVim that's preconfigured to be a full-fledged IDE. It comes with a slew of modern plugins and has an extensible configuration with reasonable defaults.

## Installation

Follow the [installation doc](https://www.lunarvim.org/docs/installation).

## Configuration

The LunarVim configs contained in this directory can be installed with [GNU stow].
Make sure you have stow installed (`brew install stow`) then run:

```
cd "$(git rev-parse --show-toplevel)" # cd to dotfiles repo root
stow -v --no-folding --restow --target "$HOME" lunarvim
```


[LunarVim]: https://www.lunarvim.org/
[GNU stow]: https://www.gnu.org/software/stow/
