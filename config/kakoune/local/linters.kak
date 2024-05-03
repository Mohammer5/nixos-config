#########################################################################################
#                                                                                       #
# ───────────────────────────────────────────────────────────────────────────────────── #
# Source: https://git.sr.ht/~ismay/desktop/tree/main/item/.config/kak/local/linters.kak #
# ───────────────────────────────────────────────────────────────────────────────────── #
#                                                                                       #
#########################################################################################

hook global BufSetOption filetype=javascript %{
  set-option buffer lintcmd "npx --no -- eslint --format=unix --stdin --stdin-filename=%val{buffile} <"
}

hook global BufWritePost filetype=javascript %{
  execute-command format
}

hook global BufSetOption filetype=css %{
  set-option buffer lintcmd "npx --no -- stylelint --formatter=unix --stdin --stdin-filename=%val{buffile} <"
}
