#!/bin/bash

dotfiles_dir=$( dirname $( readlink -f $0 ) )
cd $dotfiles_dir

function backup_and_symlink
{
    dest="$HOME/$1"
    [ -h $dest ] && return
    if [ -e $dest ]; then
        echo "Backing up $dest to $dest.bak..."
        mv $dest $dest.bak
    fi
    echo "Symlinking $1"
    ln -s $dotfiles_dir/$1 $dest
}

for f in $( ls -A | egrep '^\.' )
do
    # don't symlink this project's git files
    [[ $f == .git* ]] && continue
    # don't symlink the entire .config directory
    [[ $f == ".config" ]] && f=$f/herbstluftwm
    backup_and_symlink $f
done

backup_and_symlink .gitignore_global
