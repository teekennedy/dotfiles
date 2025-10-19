#!/usr/bin/env zsh

# Alias some common git commands
if command_exists git; then
  # gs = Git Status
  alias gs='git status'
  # gfa = Git Fetch All
  alias gfa='git fetch --all --prune'
  # gca = Git Commit Amend
  alias gca='git commit --amend --no-edit'
  # gcap = Git Commit Amend Push
  alias gcap='git commit --amend --no-edit && git push --force'
  # gca = Git Add modified Commit Amend
  alias gaca='git add -u && git commit --amend --no-edit'
  # gcap = Git Add modified Commit Amend Push
  alias gacap='git add -u && git commit --amend --no-edit && git push --force'
fi
