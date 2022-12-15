#!/usr/bin/env zsh

set -euxo pipefail

current_virtualenv="$(pyenv version-name)"
current_python="$(python --version | awk '{print $2}')"


pyenv uninstall -f $current_virtualenv
pyenv virtualenv $current_python $current_virtualenv
