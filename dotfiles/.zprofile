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

# Load zsh shell completeions from homebrew
# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
FPATH=$homebrew_prefix/share/zsh/site-functions:$FPATH

# Add local bin directory to path
PATH="$HOME/.local/bin:$PATH"

# If golang is available, add GOPATH to PATH
if command -v go &>/dev/null; then
    PATH="$(go env GOPATH)/bin:$PATH"
fi

# Source configs from zprofile config dir (if any)
for zsh_config_file ($HOME/.zsh/zprofile/*.zsh(N)); do
    source $zsh_config_file
done

# fnm (Fast Node Manager)
(( $+commands[fnm] )) && eval "$(fnm env)"

export PATH FPATH
