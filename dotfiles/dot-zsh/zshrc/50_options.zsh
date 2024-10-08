#!/usr/bin/env zsh

# Set zsh options that are unrelated to each other

# Allow comments in interactive shells
setopt interactive_comments

# Don't beep under any circumstance. This is usually disabled by the terminal,
# but set here for extra insurance.
setopt no_beep

# When a path to a directory is entered in place of a command, CD to it.
setopt auto_cd

# Use Ctrl+R to search history in reverse
bindkey '^R' history-incremental-pattern-search-backward
