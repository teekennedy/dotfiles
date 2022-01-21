#!/usr/bin/env zsh
# Setup completion options current shell

# Use menu-driven completion
zstyle ':completion:*' menu select
# Complete when cursor is in the middle of a word
setopt complete_in_word
# Move the cursor to the end of the word after completion
setopt always_to_end
# Expand aliases before looking them up in the completion system
setopt complete_aliases

# Use the following completion rules:
# '': prefer completion exactly as written
# 'm:{a-zA-Z-_}={A-Za-z_-}': case-insensitive and hyphen/underscore-insensitive completion
# 'r:|=*': Match against the right side of the string, e.g. 'bar' matches 'foobar'
# 'l:|=* r:|=*': Match any substring in the word, e.g. 'ooba' matches 'foobar'.
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
# Complete . and .. special directories
zstyle ':completion:*' special-dirs true

# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.cache/zsh

autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit
