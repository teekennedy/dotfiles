#!/bin/bash

cd ./.vim/bundle/youcompleteme/cpp
cmake -G "Unix Makefiles" -DUSE_SYSTEM_LIBCLANG=ON
make ycm_support_libs
