#!/usr/bin/env zsh
# Setup completion options current shell

# Use menu-driven completion
zstyle ':completion:*' menu select
# Complete when cursor is in the middle of a word
setopt complete_in_word
# Move the cursor to the end of the word after completion
setopt always_to_end

# Use case-insensitive and hyphen-insensitive completion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z-_}={A-Za-z_-}'
# Complete . and .. special directories
zstyle ':completion:*' special-dirs true

# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.cache/zsh

# Load zsh shell completeions from homebrew
# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

autoload -Uz +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
