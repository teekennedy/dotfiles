# Powerlevel10k

[Powerlevel10k] \(p10k) is a prompt theme for zsh. The dotfiles in this directory are used to load and configure p10k.

## Installation

`brew install powerlevel10k`

To install the dotfiles in this directory, run [`symlink_dotfiles.sh`](/symlink_dotfiles.sh).

## Configuration

To change or update the configuration, either edit the [p10k config] directly, or run `p10k configure` to generate a new `.p10k.zsh` config file in your home directory, then overwrite the existing [p10k config] in your local copy of this repo.

[Powerlevel10k]: https://github.com/romkatv/powerlevel10k
[p10k config]: dotconfig/zsh/p10k.zsh
[GNU stow]: https://www.gnu.org/software/stow/
