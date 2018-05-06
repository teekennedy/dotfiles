#!/usr/bin/env bash


# install base vim
brew install macvim --with-override-system-vim

# setup YouCompleteMe with completion for:
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

echo "Installing node for js support..."
# install node
nvm install node

echo "Installing YouCompleteMe dependencies for all completion types used"
brew install cmake rust go

echo "Compiling YouCompleteMe completion engine with support for go, js, rust and C/C++"
# setup YouCompleteMe
pushd ./dotfiles/.vim/bundle/youcompleteme
./install.py --go-completer --js-completer --rust-completer --clang-completer
popd

# make vim's swapfile directory
mkdir -p $HOME/.swp
# install dependencies of vim-go
vim -c "GoInstallBinaries" -c "q"
