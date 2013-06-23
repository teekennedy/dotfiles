#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[ -e $BASH_SOURCE-details ] && source $BASH_SOURCE-details

# modified commands
alias diff='colordiff' 				# requires colordiff package
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias g='gvim --remote-silent'
alias v='vim --remote-silent'

# Custom PS1
# Checks for 256 color terminal
if [ -t 1 ]; then

	ncolors=$(tput colors)
	if ( test -n "$ncolors" && test $ncolors -ge 256 ); then
		export PS1='\[\033[38;05;33m\]\u\[\033[0m\]@\[\033[38;05;76m\]\h \[\033[38;05;245m\]\W\[\033[38;05;33m\] >>\[\033[0m\] '
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

export PATH="~/bin:$PATH"
