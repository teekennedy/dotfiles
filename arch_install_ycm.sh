#!/bin/bash

cd ./.vim/bundle/youcompleteme
git submodule update --init --recursive
cd third_party/ycmd/cpp
cmake -G "Unix Makefiles" -DUSE_SYSTEM_LIBCLANG=ON
make ycm_support_libs
