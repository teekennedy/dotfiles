#!/bin/bash

# Determine dotfiles dir relative to the script's source directory.
# Snippet from https://stackoverflow.com/a/246128/1209614
dotfiles_dir=$( cd "$(dirname "$0")" ; pwd -P )/dotfiles

backup_and_symlink() {
    local src="$dotfiles_dir/$1"
    local dest="$HOME/$1"
    if [[ -L $dest && "$(readlink $dest)" == "$src" ]]; then
        echo "[SKP] $dest is already symlinked. Skipping."
        return
    fi
    if [ -e $dest ]; then
        # man 3 strftime
        local dest_backup="$dest.$(date "+%Y-%m-%dT%H_%M_%S").bak"
        echo "[BAK] Backing up $dest to $dest_backup"
        mv "$dest" "$dest_backup"
    else
	# ensure parent directory exists
	mkdir -p $(dirname $dest)
    fi
    echo "[SYM] Symlinking $dest to $src"
    ln -s "$src" "$dest"
}

# Backup and symlink all files in $dotfiles_dir.
for file in $(cd "$dotfiles_dir"; git ls-files); do
    backup_and_symlink $file
done
