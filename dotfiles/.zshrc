# .zshrc
# This file is sourced every time a new interactive shell is created

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source configs from zshrc config dir (if any)
for zsh_config_file ($HOME/.zsh/zshrc/*.zsh(N)); do
    source $zsh_config_file
done

# This file is for device-specific custom settings
[ -x $HOME/.zshrc-custom ] && source $HOME/.zshrc-custom

command_exists aws && complete -C $(brew --prefix)/bin/aws_completer aws

# Shortcuts to cd to:
# - iCloud drive
export CDPATH=".:$HOME/Library/Mobile Documents/com~apple~CloudDocs"

# Set default editor
if command_exists nvim; then
  export EDITOR='nvim'
elif command_exists vim; then
  export EDITOR='vim'
else
  export EDITOR='vi'
fi

# Set default options for less
# -F tells less to automatically quit if the output fits in one terminal page.
# -R tells less not to escape terminal color sequences in its output.
# -X tells less to avoid termcap init, which prevents clearing the screen.
export LESS='-FRX'

# Set pager (used by many utilities that page their output).
export PAGER='less'

# Load Powerlevel10k zsh theme from homebrew
p10k_zsh_theme=$(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme
[ -f $p10k_zsh_theme ] && source $p10k_zsh_theme
unset p10k_zsh_theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
