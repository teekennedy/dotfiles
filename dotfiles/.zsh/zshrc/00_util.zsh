#!/usr/bin/env zsh

# Utility functions for setting up zsh environment

# Checks whether a command exists. Portable with bash
command_exists() {
    command -v $1 &>/dev/null
}
