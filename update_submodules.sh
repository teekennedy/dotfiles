#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

git fetch --all
git submodule foreach 'git reset --hard origin/master'
