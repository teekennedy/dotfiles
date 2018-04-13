#!/bin/bash

# Determine dotfiles dir relative to the script's source directory.
# Snippet from https://stackoverflow.com/a/246128/1209614
dotfiles_dir=$( cd "$(dirname "$0")" ; pwd -P )/dotfiles

backup_and_symlink() {
    local dest="$HOME/$1"
    if [ -L $dest ]; then
        echo "$dest is already a symlink. Skipping."
        return
    fi
    if [ -e $dest ]; then
        echo "Backing up $dest to $dest.bak"
        mv "$dest" "$dest.bak"
    fi
    echo "Symlinking $dest to $dotfiles_dir/$1"
    ln -s "$dotfiles_dir/$1" "$dest"
}

# Backup and symlink all files in $dotfiles_dir. `ls -A` lists all files in a
# directory, excluding "." and "..".
for file in $(ls -A "$dotfiles_dir"); do
    backup_and_symlink $file
done
