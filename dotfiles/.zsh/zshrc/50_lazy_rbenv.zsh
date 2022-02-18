#!/usr/bin/env zsh

# if rbenv is a function, it's already loaded or already lazy loaded
if functions rbenv >/dev/null 2>&1; then
    return
fi

rbenv_init() {
    eval "$(rbenv init - zsh)"
}

lazy_load rbenv_init \
    bundle \
    rake \
    ruby
