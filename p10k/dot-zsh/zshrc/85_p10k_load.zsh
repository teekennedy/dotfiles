# Load Powerlevel10k zsh theme from homebrew
if command_exists brew; then
  p10k_zsh_theme="$(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme"
  [ -f $p10k_zsh_theme ] && source $p10k_zsh_theme
  unset p10k_zsh_theme
fi
