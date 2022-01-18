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

unset homebrew_prefix

# Add ~/bin directory for custom scripts
PATH="$HOME/bin:$PATH"

# Load zprofile configs 

# Source files in lib (if any)
for zsh_lib_file ($HOME/.zsh/lib/*.zsh(N)); do
    source $zsh_lib_file
done

# Source configs from zprofile config dir (if any)
for zsh_config_file ($HOME/.zsh/zprofile/*.zsh(N)); do
    source $zsh_config_file
done


# fnm (Fast Node Manager)
(( $+commands[fnm] )) && eval "$(fnm env)"

export PATH
