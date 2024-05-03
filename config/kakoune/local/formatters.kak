######################################################################################
#                                                                                    #
# ────────────────────────────────────────────────────────────────────────────────── #
# Source:                                                                            #
#   https://git.sr.ht/~ismay/desktop/tree/main/item/.config/kak/local/formatters.kak #
# ────────────────────────────────────────────────────────────────────────────────── #
#                                                                                    #
######################################################################################

hook global BufSetOption filetype=(scss|css|html|javascript|json|markdown|yaml) %{
  set-option buffer formatcmd "npx --no -- prettier --stdin-filepath=%val{buffile}"
}
