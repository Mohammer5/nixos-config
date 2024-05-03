###############
#             #
#  ─────────  #
#  User mode  #
#  ─────────  #
#  <space> u  #
#             #
###############

# ───────────
# Exiting kak
# ───────────
map global user q ':q<ret>' -docstring 'Quit kakoune (gracefully)'

# ───────────────────────────────
# Copy & Paste (system clipboard)
# ───────────────────────────────
map global user y '<a-|> xclip -selection clipboard <ret>' -docstring 'Copy to system clipboard'
map global user P '!xclip -o -selection clipboard<ret>' -docstring 'Paste above (system clipboard)'
map global user p '<a-!>xclip -o -selection clipboard<ret>' -docstring 'Paste below (system clipboard)'
map global user R '|xclip -o -selection clipboard<ret>' -docstring 'Replace (system clipboard)'
