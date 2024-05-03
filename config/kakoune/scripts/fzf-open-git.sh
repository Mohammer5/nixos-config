#!/bin/bash

log_error() {
  local message="$1"

  # Construct the command to pass to kakoune
  local kak_cmd="eval -client $kak_client echo -markup \"{Error}${message}\""

  # Echo the command back to the parent session
  echo "$kak_cmd" | kak -p "$kak_session"
}

# Local variables
kak_session="$1" kak_client="$2"

# Exit if command fails
if ! is_repo=$(git rev-parse --is-inside-work-tree); then
  log_error 'Could not run git rev-parse'
  exit 1
fi

# Exit if not in git repo
if [ "$is_repo" = false ]; then
  log_error 'Not in a git repo'
  exit 1
fi

# Get changed files
if ! files=$(git status --short --no-rename | awk -F ' ' '{print $2}'); then
  log_error 'Could not find changed files'
  exit 1
fi

if [ -z "$files" ]; then
  log_error 'No changed files found'
  exit 1
fi

# Pick a file
filename=$(echo "$files" | fzf --color=16 --preview 'cat {1}')

# Only echo a command back if there was a selection
if [ -n "$filename" ]; then
  # Construct the command to pass to kakoune
  kak_cmd="eval -verbatim -client $kak_client edit '$filename'"

  # Echo the command back to the parent session
  echo "$kak_cmd" | kak -p "$kak_session"
fi
