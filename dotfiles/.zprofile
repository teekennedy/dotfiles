#!/usr/bin/env zsh

# This file is loaded on each new zsh interactive login shell. It is the first
# user-specific file sourced by zsh on login shells.

# MacOS has a utility called path_helper that is meant to build your initial
# PATH variable from lines under /etc/paths and files under /etc/paths.d. It is
# ran by /etc/zprofile, which is read before any user-specific files (like this
# one) are read. However, on login subshells (like when spawning a new tmux
# session or window), the PATH is already set, and path_helper munges it by
# putting user-defined paths at the _end_ of the PATH, effectively disabling
# environment managers like pyenv, rbenv, and nvm.
#
# Here in ~/.zprofile (the first user-specific file sourced by zsh on login
# shells), we put user-defined paths back at the beginning of the PATH by
# separating system-wide and user-defined paths, and then rebuilding PATH in
# the correct order.
reorganize_login_subshell_path() {
    # save path as old_path
    local old_path="$PATH"
    # run path_helper against an empty PATH
    PATH=''
    eval `/usr/libexec/path_helper -s`
    # At this point the PATH contains only system-wide paths.

    # If paths are the same this is not a subshell or no user-defined paths are
    # set. In other words, the PATH is correct and there is no work to be done.
    if [ "$old_path" = "$PATH" ]; then
        return
    fi
    # Use parameter substitution to subtract system-wide paths from old_path,
    # leaving only user-defined paths. "${var#Pattern}" means "Remove from $var
    # the shortest part of $Pattern that matches the front end of $var."
    local user_defined_paths="${old_path#$PATH:}"

    # Rebuild PATH with user-defined paths prepended to system-wide paths.
    PATH="$user_defined_paths:$PATH"
}

if [ -x /usr/libexec/path_helper ]; then
    reorganize_login_subshell_path
fi
# remove path reorganization function to avoid cluttering environment
unset -f reorganize_login_subshell_path

user_defined_paths=("$HOME/bin" "/usr/local/sbin")
# Append list of paths from user_defined_paths_file
user_defined_paths_file="$HOME/.zprofile-paths"
if [[ -a "$user_defined_paths_file" ]]; then
    zmodload zsh/mapfile
    # (Z+Cn+) is zsh parameter expansion used to parse and remove comments
    # http://zsh.sourceforge.net/Doc/Release/Expansion.html
    user_defined_paths+=("${(Z+Cn+)${mapfile[$user_defined_paths_file]}}")
fi

for user_path in ${user_defined_paths[@]}; do
    # prepend user to path only if it's not already part of the path
    if [[ $PATH != *"$user_path:"* ]]; then
        # Use eval to expand any shell variables in user_defined_paths
        eval PATH=$(echo "$user_path:$PATH")
    fi
done
unset user_defined_paths user_defined_paths_file user_path

export PATH
