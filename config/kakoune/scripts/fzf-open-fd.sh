# Local variables
kak_session="$1" kak_client="$2"

# Working directory for fd defaults to the directory where kakoune was started
filename=$(fd --type=f --strip-cwd-prefix . | fzf --color=16 --preview 'cat {1}')

# Only echo a command back if there was a selection
if [ -n "$filename" ]; then
  # Construct the command to pass to kakoune
  kak_cmd="eval -verbatim -client $kak_client edit '$filename'"

  # Echo the command back to the parent session
  echo "$kak_cmd" | kak -p "$kak_session"
fi
