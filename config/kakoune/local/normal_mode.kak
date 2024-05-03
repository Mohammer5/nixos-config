# Normal mode
map global normal <ret> ':w<ret>'
map global normal '#' ':comment-line<ret>' -docstring 'comment line'

# Move selected lines down
map global normal <a-down> 'x"zd"zp'
map global normal <a-up> 'x"zdk"zP'
