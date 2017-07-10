# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/cyphus/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
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
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Use another custom folder than $ZSH/custom
ZSH_CUSTOM=$HOME/.zsh-custom


# Specify plugins to use.
# Plugins loaded from $ZSH/plugins and $ZSH_CUSTOM/plugins
plugins=(git pyenv)

source $ZSH/oh-my-zsh.sh

# DO NOT use default pyenv zsh plugin from oh-my-zsh. It is considerably slow
# and sets the wrong PYENV_ROOT! I'd create a PR to fix it but multiple already
# exist. See https://github.com/robbyrussell/oh-my-zsh/pull/6142 for further
# discussion.

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Tmux alias: attaches to the named session, creating the session if it doesn't
# already exist. Ex: t dev
alias t='tmux new -As'
