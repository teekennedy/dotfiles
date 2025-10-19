#!/bin/zsh

set -euo pipefail

# Source directory that script lives in
# Snippet from https://stackoverflow.com/a/246128/1209614
script_dir=$( cd "$(dirname "$0")" ; pwd -P )

# GNU stow is my preferred method of symlinking dotfiles.
# All dotfiles outside of the dotfiles subdirectory are managed with stow.
declare -A stow_dirs
stow_dirs=(
    [alacritty]="$HOME"
    [astro-nvim]="$HOME"
    [direnv]="$HOME"
    [dotfiles]="$HOME"
    [atuin]="$HOME"
    [git]="$HOME"
    [gpg]="$HOME"
    [nix]="$HOME"
    [p10k]="$HOME"
    [skhd]="$HOME"
    [tig]="$HOME"
    [tmux]="$HOME"
    [vivid]="$HOME"
    [yabai]="$HOME"
    [zsh-vi-mode]="$HOME"
)

# While most dotfiles are symlinked to $HOME, some require symlinking to an application-specific directory.
if [ "$(uname -s)" = "Darwin" ]; then
  if open -Ra firefox; then
      stow_dirs[firefox]="$(osascript -e 'POSIX path of (path to application "Firefox")')/Contents/Resources"
  fi
  if open -Ra "Visual Studio Code"; then
      stow_dirs[vscode]="$HOME/Library/Application Support/Code/User"
  fi
else
    ff_path="$(which firefox)"
    if [ -n "$ff_path" ]; then
        stow_dirs[firefox]="$ff_path"
    fi
fi

green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
red=$(tput setaf 1)
reset=$(tput sgr0)

run_stow() {
    local subdir="$1"
    local target="$2"
    # Confirm that target directory is writable
    if [ -w "$target" ]; then
        echo -e "${yellow}[STW]${reset} (Re)stowing dotfiles under ${blue}$subdir${reset} subdirectory"
        # Ignore warning about absolute/relative mismatch as we aren't using absolute symlinks
        # See https://github.com/aspiers/stow/issues/65 for context.
        stow --no-folding --dotfiles --restow --target "$target" --dir "$script_dir" "$subdir" \
            2> >(grep -v 'BUG in find_stowed_path? Absolute/relative mismatch' 1>&2)
    else
        echo -e "${red}[ERR]${reset} Not stowing files under $blue$subdir$reset: Target dir ${blue}$target${reset} is not writable."
    fi
}

for stow_dir target_dir in ${(kv)stow_dirs}; do
    run_stow "$stow_dir" "$target_dir"
done

echo "Done"
