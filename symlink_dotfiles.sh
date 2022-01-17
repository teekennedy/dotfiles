#!/bin/bash

# Determine dotfiles dir relative to the script's source directory.
# Snippet from https://stackoverflow.com/a/246128/1209614
dotfiles_dir=$( cd "$(dirname "$0")" ; pwd -P )/dotfiles

green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
reset=`tput sgr0`

backup_and_symlink() {
    local src="$dotfiles_dir/$1"
    local dest="$HOME/$1"
    if [[ -L $dest && "$(readlink $dest)" == "$src" ]]; then
        echo -e "${green}[SKP]${reset} $dest is already symlinked. Skipping."
        return
    fi
    if [ -e $dest ]; then
        # man 3 strftime
        local dest_backup="$dest.$(date "+%Y-%m-%dT%H_%M_%S").bak"
        echo "${yellow}[BAK]${reset} Backing up $dest to $dest_backup"
        mv "$dest" "$dest_backup"
      else
        # ensure parent directory exists
        mkdir -p $(dirname $dest)
    fi
    echo "${blue}[SYM]${reset} Symlinking $dest to $src"
    ln -s "$src" "$dest"
}

cleanup_broken_symlinks() {
    echo "Finding and removing any broken symlinks to the dotfiles directory."
    find $HOME -lname "$dotfiles_dir/*" -type l ! -exec test -e {} \; -print -delete
}

# Backup and symlink all files in $dotfiles_dir.
for file in $(cd "$dotfiles_dir"; git ls-files); do
    backup_and_symlink $file
done

cleanup_broken_symlinks
echo "Done"
