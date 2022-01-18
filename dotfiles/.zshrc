# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# .zshrc
# This file is sourced every time a new shell is created (login or not)

# Helper function to check whether a command exists
command_exists() {
    command -v $1 &>/dev/null
}

# Shortcuts to cd to
export CDPATH=".:$HOME/Library/Mobile Documents/com~apple~CloudDocs"

# Source configs from zshrc config dir (if any)
for zsh_config_file ($HOME/.zsh/zshrc/*.zsh(N)); do
    source $zsh_config_file
done

# This file is for device-specific custom settings
[ -x $HOME/.zshrc-custom ] && source $HOME/.zshrc-custom

command_exists aws && complete -C $(brew --prefix)/bin/aws_completer aws

export EDITOR='vim'

# Set pager (used by many utilities that page their output).
export PAGER='less'
# Set default options for less
# -F tells less to automatically quit if the output fits in one terminal page.
# -R tells less not to escape terminal color sequences in its output.
# -X tells less to avoid termcap init, which prevents clearing the screen.
export LESS='-FRX'


# Aliases

# Tmux alias: attaches to the named session, creating the session if it doesn't
# already exist. Ex: t dev
command_exists tmux && alias t='tmux new -As'

# Alias diff to colordiff if available
command_exists colordiff && alias diff='colordiff'

# Alias vim to neovim if available
command_exists nvim && alias vim='nvim'

# Alias some common git commands
if command_exists git; then
    alias gfa='git fetch --all --prune'
fi

# Alias cat to bat https://github.com/sharkdp/bat if available
if command_exists bat; then
    alias cat='bat --paging=never'
    # Assumes you've set aws-cli to use json output
    export AWS_PAGER='bat -l json'

    # batman from bat-extras
    # https://github.com/eth-p/bat-extras/blob/master/doc/batman.md
    command_exists batman && alias man='batman'
fi

# Alias for copying the output of my yubikey 2FA codes.
#     Ex: auth aws -> paste into aws
if command_exists ykman; then
    auth() {
        ykman oath accounts code -s $1 2> >(sed 's/Touch/Tap/' 1>&2) | pbcopy
    }
fi

# Load Powerlevel10k zsh theme
p10k_zsh_theme=$(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme
[ -f $p10k_zsh_theme ] && source $p10k_zsh_theme
unset p10k_zsh_theme

unset -f command_exists

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.zsh/p10k.zsh ]] || source ~/.zsh/p10k.zsh
