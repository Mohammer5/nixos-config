hook global BufCreate .* editorconfig-load
hook global BufOpenFile .* %{ editorconfig-load }
hook global BufNewFile .* %{ editorconfig-load }
