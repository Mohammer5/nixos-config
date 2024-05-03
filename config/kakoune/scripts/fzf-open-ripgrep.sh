#!/bin/bash

# Local variables
kak_session="$1" kak_client="$2"

filename=$(
  fzf \
    --bind "change:reload:rg --files-with-matches --smart-case --fixed-strings {q} || true" \
    --color=16 \
    --disabled \
    --layout=reverse \
    --preview="rg --smart-case --line-number --color always --context 2 {q} {1}"
)

# Only echo a command back if there was a selection
if [ -n "$filename" ]; then
  # Construct the command to pass to kakoune
  kak_cmd="eval -verbatim -client $kak_client edit '$filename'"

  # Echo the command back to the parent session
  echo "$kak_cmd" | kak -p "$kak_session"
fi
