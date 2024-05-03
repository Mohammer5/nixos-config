# Goto file
###########

map global goto f '<esc>:goto-file<ret>' -docstring 'file'

# in some languages the file extension is optional
declare-option -hidden str goto_file_suffix ''
declare-option -hidden str goto_index_suffix ''

hook global WinSetOption filetype=(javascript|ecmascript) %{
  # require() / import from
  set-option buffer goto_file_suffix '.js'
  set-option buffer goto_index_suffix '/index.js'
}

hook global WinSetOption filetype=(typescript) %{
  # import from
  set-option buffer goto_file_suffix '.ts'
  set-option buffer goto_index_suffix '/index.ts'
}

define-command goto-file -docstring 'goto filepath in string on current line' %{
  # select-next-string
  execute-keys gh /['"][^'"\n]*?['"]<ret>
  # shrink-selection
  execute-keys '<a-:>H<a-;>L'
  # relative path handling
  declare-option -hidden str goto_dir "%sh{dirname ""$kak_buffile""}/"

  try %{
    # relative path without suffix
    edit -existing "%opt{goto_dir}%val{selection}"
  } catch %{
    # with file suffix
    edit -existing "%opt{goto_dir}%val{selection}%opt{goto_file_suffix}"
  } catch %{
    # with index suffix
    edit -existing "%opt{goto_dir}%val{selection}%opt{goto_index_suffix}"
  } catch %{
    fail "gf: files not found %opt{goto_dir}%val{selection} (%opt{goto_file_suffix}|%opt{goto_index_suffix})"
  }
}
