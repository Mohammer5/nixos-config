declare-user-mode highlight
map global user h ':enter-user-mode highlight<ret>' -docstring 'highlight text'
map global highlight m ':mark-word<ret>' -docstring 'Highlight word under the curser'
map global highlight c ':mark-clear<ret>' -docstring 'Remove highlight of word under curser'
