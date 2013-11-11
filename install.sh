#!/bin/bash

dotfiles_dir=$( cd "$(dirname "$0")" ; pwd -P )
cd $dotfiles_dir

function backup_and_symlink
{
    dest="$HOME/$1"
    echo $dest
    [ -L $dest ] && return
    if [ -e $dest ]; then
        echo "Backing up $dest to $dest.bak..."
        mv $dest $dest.bak
    fi
    echo "Symlinking $1"
    ln -s $dotfiles_dir/$1 $dest
}

for f in $( ls -A | egrep '^\.' | grep -v 'git' )
do
    backup_and_symlink $f
done

backup_and_symlink .gitignore_global
