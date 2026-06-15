#!/usr/bin/env zsh

# Alias some common git commands
if command_exists git; then
  # gb = Git Branch
  alias gb='git branch'
  # gd = Git Diff
  alias gd='git diff'
  # gdc = Git Diff Cached
  alias gdc='git diff --cached'
  # gs = Git Status
  alias gs='git status'
  # gup = Git Update
  alias gup='git update'
  # gfa = Git Fetch All
  alias gfa='git fetch --all --prune'
  # gcan = Git Commit Amend No edit
  alias gcan='git commit --amend --no-edit'
  # gcap = Git Commit Amend Push
  alias gcap='git commit --amend --no-edit && git push --force'
  # gaca = Git Add modified Commit Amend
  alias gaca='git add -u && git commit --amend --no-edit'
  # gcap = Git Add modified Commit Amend Push
  alias gacap='git add -u && git commit --amend --no-edit && git push --force'
fi
