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

# Thanks to https://gist.github.com/ctechols/ca1035271ad134841284 for this snippet
#
# On slow systems, checking the cached .zcompdump file to see if it must be 
# regenerated adds a noticable delay to zsh startup.  This little hack restricts 
# it to once a day.  It should be pasted into your own completion file.
#
# The globbing is a little complicated here:
# - '#q' is an explicit glob qualifier that makes globbing work within zsh's [[ ]] construct.
# - 'N' makes the glob pattern evaluate to nothing when it doesn't match (rather than throw a globbing error)
# - '.' matches "regular files"
# - 'mh+24' matches files (or directories or whatever) that are older than 24 hours.
autoload -Uz compinit
_zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
# If .zcompdump exists and is non-empty (-s) and is less than 24 hours old
if [[ -s "$_zcompdump" && ! -n "$_zcompdump"(#qN.mh+24) ]]; then
	compinit -C
else
	compinit
fi

autoload -U +X bashcompinit && bashcompinit
