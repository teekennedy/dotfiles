# From https://github.com/romkatv/powerlevel10k/blob/master/README.md#how-do-i-initialize-direnv-when-using-instant-prompt
# I added the DIRENV_WARN_TIMEOUT variable to suppress a direnv warning when commands take awhile to execute
# https://github.com/direnv/direnv/pull/1209

if (( ${+commands[direnv]} )); then
  emulate zsh -c "$(direnv export zsh)"
  export DIRENV_WARN_TIMEOUT=0
fi
