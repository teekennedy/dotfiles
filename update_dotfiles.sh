#!/usr/bin/env bash

# Source directory that script lives in
# Snippet from https://stackoverflow.com/a/246128/1209614
script_dir=$( cd "$(dirname "$0")" ; pwd -P )

git pull
git submodule sync
git submodule update --init --recursive
$script_dir/symlink_dotfiles.sh
nvim -c 'CocUpdateSync | TSUpdate all | helptags ALL | q'
