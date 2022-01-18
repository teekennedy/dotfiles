#!/usr/bin/env zsh

# if pyenv is a function, it's already loaded or already lazy loaded
if functions pyenv >/dev/null 2>&1; then
    return
fi

pyenv_init() {
    # prevent pyenv-virtualenv from prepending the virtualenv name to the prompt
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
    eval "$(pyenv init --path)"
    eval "$(pyenv virtualenv-init - zsh)"
}

lazy_load pyenv_init \
    black \
    infra \
    pip \
    pipdeptree \
    pyenv \
    pyright \
    pytest \
    ptw \
    python \
    python2 \
    python3 \
    tmuxp
