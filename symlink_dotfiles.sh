#!/bin/bash

# Run script commands relative to the script's source directory.
# Snippet from https://stackoverflow.com/a/246128/1209614
dotfiles_dir=$( cd "$(dirname "$0")" ; pwd -P )

function backup_and_symlink
{
    dest="$HOME/$1"
    if [ -L $dest ]; then
        echo "$dest is already a symlink. Skipping."
        return
    fi
    if [ -e $dest ]; then
        echo "Backing up $dest to $dest.bak..."
        mv "$dest" "$dest.bak"
    fi
    echo "Symlinking $dest to $dotfiles_dir/$1"
    ln -s "$dotfiles_dir/$1" "$dest"
}

# Backup all dotfiles/dotfolders in the top level directory, skipping
# repository-specific files/folders like ".git". The `git ls-tree` command
# lists all git managed files and folders in the top level directory.
for file in $( git -C "$dotfiles_dir" ls-tree --name-only HEAD | egrep '^\.' )
do
    backup_and_symlink $file
done
