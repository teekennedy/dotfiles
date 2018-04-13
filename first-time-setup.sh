#!/usr/bin/env bash


# find the dotfiles repo location relative to this script
dotfiles_repo_path=$( cd "$(dirname "$0")" ; pwd -P )
cd $dotfiles_repo_path

# setup submodules
git submodule update --init --recursive

# Install Xcode Command Line Tools:
echo "installing Xcode Command Line Tools..."
xcode-select --install

# Macvim requires full Xcode to be installed
echo "install Xcode through the App Store manually, then press Enter.."
read

echo "Launching Xcode. It will prompt you to install additional components. Install them."
open xcode

echo "Agreeing to Xcode License. Enter to continue, Ctrl-C to quit"
read

sudo xcodebuild -license accept

echo "Installing homebrew..."
# Install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing base dependencies for dotfiles support..."
# install dotfile dependencies
brew install \
    macvim --with-override-system-vim   `# my preferred text editor` \
    tmux                                `# terminal multiplexer` \
    git                                 `# version control system` \
    pyenv                               `# python version manager` \
    pyenv-virtualenv                    `# python virtualenv manager` \
    rbenv                               `# ruby version manager` \
    zsh                                 `# z shell`

# install powerline font for zsh/vim statusline support
brew tap caskroom/fonts
brew cask install font-source-code-pro-for-powerline

# install casks
brew cask install iterm2 slack spotify

# install custom iterm2 color scheme
open iterm2/cyphus.itermcolors

# todo install iterm2 settings

# YouCompleteMe setup with completion for:
#  - C/C++
#  - go
#  - javascript
#  - rust

echo "Installing dependencies for YouCompleteMe..."
echo "Installing nvm..."
# install nvm (node version manager). Node is used by YouCompleteMe
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
# load nvm into current environment
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm


echo "Installing node..."
# install node
nvm install node

# install YouCompleteMe dependencies for all completion types used
brew install cmake rust go

echo "Compiling YouCompleteMe completion engine with support for go, js, rust and C/C++"
# setup YouCompleteMe
pushd ./dotfiles/.vim/bundle/youcompleteme
./install.py --go-completer --js-completer --rust-completer --clang-completer
popd

# make vim's swapfile directory
mkdir -p $HOME/.swp

# clone my fork of oh-my-zsh
# TODO make this a submodule instead
git clone git@github.com:cyphus/oh-my-zsh.git $HOME/.oh-my-zsh
