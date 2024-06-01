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

print_buffers "$@" | fzf -m --color=16 | while read line; do
  kak_cmd="eval -client $kak_client delete-buffer $line"
  echo "$kak_cmd" | kak -p "$kak_session"
done
