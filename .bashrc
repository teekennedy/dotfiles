#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# modified commands
alias diff='colordiff' 				# requires colordiff package
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h -c'
alias mkdir='mkdir -p -v'
alias ping='ping -c 5'
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

# yaourt complains if I don't set this to something.
export EDITOR="vim"

# remove all previous duplicates in command history before saving the current one
export HISTCONTROL="erasedups"

# have easy access to projects
export CDPATH=".:~:~/Dropbox/dev/68k/Projects"

export TIGCC="/usr/local/share/gcc4ti"
export PATH="$PATH:$TIGCC/bin"
