#!/usr/bin/env bash

# Install Xcode Command Line Tools:

xcode-select --install

# Install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install dotfile dependencies
brew install \
    macvim --with-override-system-vim   `# my preferred text editor` \
    tmux                                `# terminal multiplexer` \
    git                                 `# version control system` \
    pyenv                               `# python version manager` \
    pyenv-virtualenv                    `# python virtualenv manager` \
    rbenv                               `# ruby version manager` \
    zsh                                 `# z shell`

# install casks
brew cask install iterm2 slack spotify

# setup submodules
git submodule update --init --recursive

# make vim's swapfile directory
mkdir -p $HOME/.swp

# clone my fork of oh-my-zsh
git clone git@github.com:cyphus/oh-my-zsh.git $HOME/.oh-my-zsh
