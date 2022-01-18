#!/usr/bin/env zsh

# Zsh history configuration. See man zshopts for info

# History size and save file
HISTFILE="$HOME/.zsh_history"
HISTSIZE=500000
SAVEHIST=500000

# Overwrite the default history alias:
#  -n: suppress incremental numbering from output
#  -i: print full ISO-8601 timestamp for each entry
#  -l 1: list full history starting from 1
alias history='fc -nil 1'

## History configuration
setopt extended_history         # record timestamp of command in HISTFILE
setopt hist_ignore_all_dups     # do not put duplicated command into history list
setopt hist_ignore_dups         # ignore duplicated commands history list
setopt hist_ignore_space        # ignore commands that start with space
setopt hist_reduce_blanks       # remove unnecessary blanks
setopt hist_save_no_dups        # do not save duplicated command
setopt inc_append_history_time  # append command to history file immediately after execution
