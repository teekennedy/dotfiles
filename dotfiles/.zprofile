#!/usr/bin/env zsh

# This file is loaded on each new zsh interactive login shell. It is the first
# user-specific file sourced by zsh on login shells.

# Add paths for homebrew based on its prefix, which in turn is based on whether
# we're on Apple Silicon
if [[ $(sysctl -n machdep.cpu.brand_string) = Apple* ]] ; then
    homebrew_prefix="/opt/homebrew"
else
    homebrew_prefix="/usr/local"
fi

# Set homebrew shell environment variables
eval $($homebrew_prefix/bin/brew shellenv)

# Add ~/bin directory for custom scripts
PATH="$HOME/bin:$PATH"

# Load version managers

# fnm (Fast Node Manager)
(( $+commands[fnm] )) && eval "$(fnm env)"

export PATH

# Load zsh shell completeions from homebrew
# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

    autoload -Uz compinit
    compinit
fi

