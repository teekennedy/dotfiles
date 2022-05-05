#!/usr/bin/env zsh
# Setup aliases and functions to be used interactively

# Filesystem navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ll="ls -lah"

# Tmux alias: attaches to the named session, creating the session if it doesn't
# already exist. Ex: t dev
command_exists tmux && alias t='tmux new -As'

# Alias diff to colordiff if available
command_exists colordiff && alias diff='colordiff'

# Alias vim to neovim if available
command_exists nvim && alias vim='nvim'

# Alias some common git commands
if command_exists git; then
    # gfa = Git Fetch All
    alias gfa='git fetch --all --prune'
    # gca = Git Commit Amend
    alias gca='git add -u && git commit --amend --no-edit'
    # gcap = Git Commit Amend Push
    alias gcap='git add -u && git commit --amend --no-edit && git push --force'
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

# Alias tf to terraform if available
command_exists terraform && alias tf='terraform'

# Alias tg to terragrunt if available
command_exists terraform && alias tg='terragrunt'

# Alias for copying the output of my yubikey 2FA codes.
#     Ex: auth aws -> paste into aws
if command_exists ykman; then
    auth() {
        ykman oath accounts code -s $1 2> >(sed 's/Touch/Tap/' 1>&2) | pbcopy
    }
fi

