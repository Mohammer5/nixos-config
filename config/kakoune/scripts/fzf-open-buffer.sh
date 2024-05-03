#!/bin/bash

# Local variables
kak_session="$1" kak_client="$2"

# Get remaining arguments
shift 2

# Appends 'modified' symbol to buffer names
print_buffers() {
  for buffer in "$@"; do
    filename=${buffer%_*}
    modified=${buffer##*_}

    if [ "$modified" = "true" ]; then
      modified_symbol=' [+]'
    else
      modified_symbol=''
    fi

    echo "$filename$modified_symbol"
  done
}

# Pick from list of open buffers
selection=$(print_buffers "$@" | fzf --color=16)

echo "Kak session: $kak_session\n" >> /tmp/kakoune
echo "Kak client: $kak_client\n" >> /tmp/kakoune

# Only echo a command back if there was a selection
if [ -n "$selection" ]; then
  # Remove any 'modified' symbols from selection
  filename=${selection% *}

  # Construct the command to pass to kakoune
  kak_cmd="eval -client $kak_client edit $filename"

  # Echo the command back to the parent session
  echo "$kak_cmd" | kak -p "$kak_session"
fi
