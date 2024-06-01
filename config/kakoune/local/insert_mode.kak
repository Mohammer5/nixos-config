# map global insert jk '<esc>'
hook global InsertChar k %{ try %{
  exec -draft hH <a-k>jk<ret> d
  exec <esc>
}}

# Paste with ctrl-v
map global insert <c-v> '<a-;>P<a-;>l'

# Backwards-delete word
map global insert <c-backspace> '<left><a-;>B<a-;>"_d'
