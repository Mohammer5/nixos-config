kak_session="$1"
kak_client="$2"

fileinfo=$(
  fzf \
    --bind 'start:reload:rg --column --line-number --smart-case -F ""' \
    --bind "change:reload:rg --column --line-number --smart-case {q} | cut -d ':' -f 1-3 || true" \
    --color=16 \
    --disabled \
    --layout=reverse \
    --preview="echo {1} | cut -d':' -f1 | xargs rg --smart-case --line-number --color always --context 2 {q}"
)

filename=$(echo $fileinfo | cut -d ':' -f 1)
file_column=$(echo $fileinfo | cut -d ':' -f 2)
file_row=$(echo $fileinfo | cut -d ':' -f 3)

# Only echo a command back if there was a selection
if [ -n "$filename" ]; then
  # Construct the command to pass to kakoune
  kak_cmd="eval -verbatim -client $kak_client edit $filename $file_column $file_row"

  # Echo the command back to the parent session
  echo "$kak_cmd" | kak -p "$kak_session"
fi

# kak_session="$1"
# kak_client="$2"

# # Use git ls-files to get all relevant files (tracked and unignored)
# fileinfo=$(git ls-files --cached --others --exclude-standard \
#   | xargs grep -nH "" \
#   | fzf \
#     --color=16 \
#     --layout=reverse \
#     --preview="echo {} | cut -d':' -f1 | xargs -I{} bat --style=numbers --color=always {} --line-range \$(echo {} | cut -d':' -f2):\$(echo {} | cut -d':' -f2)" \
# )

# filename=$(echo "$fileinfo" | cut -d ':' -f 1)
# file_row=$(echo "$fileinfo" | cut -d ':' -f 2)

# # Only echo a command back if there was a selection
# if [ -n "$filename" ]; then
#   kak_cmd="eval -verbatim -client $kak_client edit $filename $file_row"
#   echo "$kak_cmd" | kak -p "$kak_session"
# fi





# # #!/bin/bash

# # kak_session="$1"
# # kak_client="$2"

# # fileinfo=$(
# #   fzf \
# #     --bind 'start:reload:rg --column --line-number --smart-case -F ""' \
# #     --bind "change:reload:rg --column --line-number --smart-case {q} | cut -d ':' -f 1-3 || true" \
# #     --color=16 \
# #     --disabled \
# #     --layout=reverse \
# #     --preview="echo {1} | cut -d':' -f1 | xargs rg --smart-case --line-number --color always --context 2 {q}"
# # )

# # filename=$(echo $fileinfo | cut -d ':' -f 1)
# # file_column=$(echo $fileinfo | cut -d ':' -f 2)
# # file_row=$(echo $fileinfo | cut -d ':' -f 3)

# # # Only echo a command back if there was a selection
# # if [ -n "$filename" ]; then
# #   # Construct the command to pass to kakoune
# #   kak_cmd="eval -verbatim -client $kak_client edit $filename $file_column $file_row"

# #   # Echo the command back to the parent session
# #   echo "$kak_cmd" | kak -p "$kak_session"
# # fi
