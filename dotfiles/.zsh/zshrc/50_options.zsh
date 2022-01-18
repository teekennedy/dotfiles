#!/usr/bin/env zsh

# Set zsh options that are unrelated to each other

# Allow comments in interactive shells
setopt interactive_comments

# Allow extended glob patterns. See man zshexpn for options
setopt extended_glob

# Don't beep under any circumstance. This is usually disabled by the terminal,
# but set here for extra insurance.
setopt no_beep
