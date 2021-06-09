# Set PATH in ~/.zprofile
export CDPATH=$HOME/go/src/github.com/cyphus

# This file is for device-specific custom settings
[ -x $HOME/.zshrc-custom ] && . $HOME/.zshrc-custom

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="bullet-train"

BULLETTRAIN_PROMPT_ORDER=(status cmd_exec_time dir local_pyenv git)
BULLETTRAIN_DIR_BG='black'
BULLETTRAIN_DIR_FG='default'
BULLETTRAIN_GIT_BG='blue'
BULLETTRAIN_GIT_FG='default'
BULLETTRAIN_PYENV_FG='default'
BULLETTRAIN_STATUS_FG='default'
# only show clean/dirty working tree state
BULLETTRAIN_GIT_EXTENDED='false'
BULLETTRAIN_PROMPT_ADD_NEWLINE='false'
BULLETTRAIN_PROMPT_SEPARATE_LINE='true'
BULLETTRAIN_STATUS_EXIT_SHOW='true'

# disable pyenv-virtualenv from prepending the current virtualenv to the prompt
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# OMZ's auto title interferes with tmux window's titles, so we turn it off.
# https://github.com/robbyrussell/oh-my-zsh/pull/257
# Uncomment the following line to disable auto-setting terminal title.
# Must be exported to be available to tmux subshells.
export DISABLE_AUTO_TITLE="true"

# I don't like autocorrect, it interrupts workflow with a prompt.
ENABLE_CORRECTION="false"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Set the timestamp format used in the history command.
# I prefer my timestamps ISO 8601 for sortability.
HIST_STAMPS="yyyy-mm-dd"

# Specify plugins to use.
# Plugins loaded from $ZSH/plugins and $ZSH_CUSTOM/plugins
plugins=(git)

source $ZSH/oh-my-zsh.sh

EDITOR='vim'
# Turn off paging output of AWS cli commands by setting this variable to an
# empty string.
AWS_PAGER=''

# By default, OMZ performs history expansion on the current line and pause to
# verify before running. I prefer my history expanded commands instant.
unsetopt HIST_VERIFY

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Tmux alias: attaches to the named session, creating the session if it doesn't
# already exist. Ex: t dev
alias t='tmux new -As'

# Alias for copying the output of my yubikey 2FA codes.
#     Ex: auth aws -> paste into aws
function auth() {
    ykman oath accounts code $1 | awk '{ print $2 }' | pbcopy
}
