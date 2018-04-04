export PATH=$HOME/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/cyphus/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="bullet-train"

BULLETTRAIN_PROMPT_ORDER=(status context dir local_pyenv git cmd_exec_time)
# if the current user matches the default user, context segment is omitted
BULLETTRAIN_CONTEXT_DEFAULT_USER='cyphus'
BULLETTRAIN_DIR_BG='black'
BULLETTRAIN_DIR_FG='white'
BULLETTRAIN_GIT_BG='blue'
BULLETTRAIN_GIT_FG='white'
# only show clean/dirty working tree state
BULLETTRAIN_GIT_EXTENDED='false'
BULLETTRAIN_PROMPT_ADD_NEWLINE='false'
BULLETTRAIN_PROMPT_SEPARATE_LINE='true'
BULLETTRAIN_STATUS_EXIT_SHOW='true'

# disable pyenv-virtualenv from prepending the current virtualenv to the prompt
PYENV_VIRTUALENV_DISABLE_PROMPT=1

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
DISABLE_AUTO_TITLE="true"

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