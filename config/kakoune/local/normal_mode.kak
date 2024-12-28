# Normal mode
map global normal <ret> ':w<ret>'
map global normal '#' ':comment-line<ret>' -docstring 'comment line'

# ------------------------
# Move selected lines down
# ------------------------

provide-module move-line %{
  # Move selected lines below
  define-command move-line-below -docstring 'Move selected lines below' %{
    # Select whole lines
    execute-keys '<a-x><a-_><a-:>'

    # Iterate each selection and move the lines below
    evaluate-commands -itersel %{
      execute-keys -draft 'w'
      execute-keys -draft 'Zj<a-x>dzP'
    }
  }

  # Move selected lines above
  define-command move-line-above -docstring 'Move selected lines above' %{
    # Select whole lines
    execute-keys '<a-x><a-_><a-:>'

    # Iterate each selection and move the lines above
    evaluate-commands -itersel %{
      execute-keys -draft '<a-;>b'
      execute-keys -draft '<a-;>Zk<a-x>dzp'
    }
  }
}

map global normal <down> ': move-line-below<ret>'
map global normal <up> ': move-line-above<ret>'
# map global normal <a-up> 'kghCx<a-)>;,'
# map global normal <a-down> 'ghCx<a-)>;,j'
