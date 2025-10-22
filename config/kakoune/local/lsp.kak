#**
# LSP
#**

# eval %sh{kak-lsp --kakoune -s $kak_session}
# hook global WinSetOption filetype=(javascript|typescript) %{
#     lsp-enable-window
# }

# map global user l ':enter-user-mode lsp<ret>' -docstring "LSP mode"
