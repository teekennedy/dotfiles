# Tig

[Tig] is a text mode interface for git.

## Installation

`brew install tig`

## Configuration

The [Tig] config file contained in this directory can be installed with [GNU stow].
Make sure you have stow installed (`brew install stow`) then run:

```
cd "$(git rev-parse --show-toplevel)" # cd to dotfiles repo root
stow -v --no-folding --restow --target "$HOME" tig
```


[Tig]: https://jonas.github.io/tig/
[GNU stow]: https://www.gnu.org/software/stow/
