#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[ -e $BASH_SOURCE-details ] && source $BASH_SOURCE-details

# modified commands
alias diff='colordiff'                 # requires colordiff package
alias grep='grep --color=auto'
alias g='gvim --remote-silent'
alias v='vim --remote-silent'
alias startx='ssh-agent startx'

# vi keybindings in bash
set -o vi

export TERM="xterm-256color"

# Custom PS1
# Checks for 256 color terminal
if [ -t 1 ]; then

    ncolors=$(tput colors)
    if ( test -n "$ncolors" && test $ncolors -ge 256 ); then
        export PS1='\[\033[38;5;76m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[\033[38;5;81m\]\h\[$(tput sgr0)\]\[\033[38;5;214m\]$(__git_ps1 "(%s)")\[$(tput sgr0)\]\[\033[38;5;7m\] \W \[$(tput sgr0)\]\[\033[38;5;15m\]\\$\[$(tput sgr0)\] '
    elif ( test -n "$ncolors" && test $ncolors -ge 8 ); then
        export PS1='\[\e[0;34m\]\u\[\e[m\]@\[\e[3;32m\]\h \[\e[m\]\W \[\e[0;34m\]>>\[\e[m\] '
    else
        export PS1='\u@\h \W >> '
    fi
fi

export EDITOR="vim"

# remove all previous duplicates in command history before saving the current one
export HISTCONTROL="erasedups"
export HISTFILESIZE=2500

export PATH="$HOME/bin:$PATH"

# function to query available packages
nix? (){ nix-env -qa \* -P | fgrep -i "$1"; }
