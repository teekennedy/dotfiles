#!/usr/bin/env zsh
# Setup aliases and functions to be used interactively

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
    command_exists aws && export AWS_PAGER='bat -l json'

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

