#!/bin/bash

set -euo pipefail

# Source directory that script lives in
# Snippet from https://stackoverflow.com/a/246128/1209614
script_dir=$( cd "$(dirname "$0")" ; pwd -P )

# GNU stow is my preferred method of symlinking dotfiles.
# All dotfiles outside of the dotfiles subdirectory are managed with stow.
stow_dirs=(
    alacritty
    direnv
    fzf
    lunarvim
    nix
    p10k
    tig
    vivid
)

# dotfiles directory relative to script_dir
dotfiles_dir="dotfiles"

# This script saves the last commit it was ran against to intelligently add, update, and remove
# symlinks according to changes since that commit.
last_symlinked_file="$script_dir/.last_symlinked"

if [ -f "$last_symlinked_file" ]; then
    last_symlinked="$(cat "$last_symlinked_file")"
else
    # Default last_symlinked to the first commit in this repo
    # https://stackoverflow.com/a/5189296/1209614
    last_symlinked="$(git rev-list --max-parents=0 HEAD)"
fi

green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
reset=$(tput sgr0)

run_stow() {
    local subdir="$1"
    echo -e "${yellow}[STW]${reset} (Re)stowing dotfiles under ${blue}$subdir${reset} subdirectory"
    # Ignore warning about absolute/relative mismatch as we aren't using absolute symlinks
    # See https://github.com/aspiers/stow/issues/65 for context.
    stow --no-folding --restow --target "$HOME" --dir "$script_dir" "$subdir" \
        2> >(grep -v 'BUG in find_stowed_path? Absolute/relative mismatch' 1>&2)
}

backup_and_symlink() {
    local src="$script_dir/$dotfiles_dir/$1"
    local dest="$HOME/$1"
    if [[ -L $dest && "$(readlink "$dest")" == "$src" ]]; then
        echo -e "${green}[SKP]${reset} $dest is already symlinked. Skipping."
        return
    fi
    if [ -e "$dest" ]; then
        # man 3 strftime
        local dest_backup
        dest_backup="$dest.$(date "+%Y-%m-%dT%H_%M_%S").bak"
        echo "${yellow}[BAK]${reset} Backing up $dest to $dest_backup"
        mv "$dest" "$dest_backup"
      else
        # ensure parent directory exists
        mkdir -p "$(dirname "$dest")"
    fi
    echo "${blue}[SYM]${reset} Symlinking $dest to $src"
    ln -s "$src" "$dest"
}

cleanup_broken_symlink() {
    local src="$script_dir/$dotfiles_dir/$1"
    local dest="$HOME/$1"
    if [[ -L $dest && ! -e $dest ]]; then
        echo "${blue}[REM]${reset} Removing symlink $dest to deleted file $1"
        rm "$dest"
    else
        echo "${green}[SKP]${reset} No broken symlink found at $dest"
    fi
}

dotfiles_changed_since() {
    local commit=$1
    local filter=$2
    cd "$script_dir/$dotfiles_dir"
    # Show filenames relative to dotfiles dir that match the given filter
    # --no-renames disables rename detection, showing renamed files as addition / removal pairs
    git diff --name-only --relative --no-renames --diff-filter="$filter" "$commit"
}

for stow_dir in "${stow_dirs[@]}"; do
    run_stow "$stow_dir"
done

# Backup and symlink all new files in dotfiles subdirectory
for file in $(dotfiles_changed_since "$last_symlinked" A); do
    backup_and_symlink "$file"
done

# Remove symlinks for all deleted and renamed files under dotfiles subdirectory
for file in $(dotfiles_changed_since "$last_symlinked" D); do
    cleanup_broken_symlink "$file"
done

git rev-parse HEAD > "$last_symlinked_file"

echo "Done"
