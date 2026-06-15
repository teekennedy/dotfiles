if (( ${+commands[devenv]} )); then
  export DEVENV_TUI=false
  eval "$(devenv hook zsh)"
fi
