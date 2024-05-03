#!/bin/bash

# Local variables
kak_buffile="$1" kak_session="$2" kak_client="$3"

# Get working directory of current buffer
kak_pwd=$(dirname "${kak_buffile}")

# Pick a file with lf
filename=$(lf -print-selection "${kak_pwd}")

# Only echo a command back if there was a selection
if [ -n "$filename" ]; then
  # Construct the command to pass to kakoune
  kak_cmd="eval -verbatim -client $kak_client edit '$filename'"

  # Echo the command back to the parent session
  echo "$kak_cmd" | kak -p "$kak_session"
fi
