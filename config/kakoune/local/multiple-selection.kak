declare-user-mode selection
map global user s ':enter-user-mode selection<ret>' -docstring 'selection mode'
map global selection w <a-i>w*N -docstring 'Select word under cursor and next occurrence'
map global selection n *N -docstring 'Select next occurrence'
