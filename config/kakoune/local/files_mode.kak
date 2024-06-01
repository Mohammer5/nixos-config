#**
# Buffer management
#**

# Files mode
declare-user-mode files
map global user f ':enter-user-mode files<ret>' -docstring 'files mode'
map global files f ':fzf-open-fd<ret>' -docstring 'pick a file with fd'
map global files g ':fzf-open-git<ret>' -docstring 'pick a file with git'
map global files b ':fzf-open-buffer<ret>' -docstring 'pick a file from open buffers'
map global files d ':fzf-delete-buffer<ret>' -docstring 'delete an open buffers'
map global files s ':fzf-open-rg<ret>' -docstring 'search current buffer'
map global files l ':lf-open<ret>' -docstring 'pick a file with lf'

define-command fzf-open-fd -docstring 'Pick a file with fd' %{
  nop %sh{
    st -e "$kak_config"/scripts/fzf-open-fd.sh "$kak_session" "$kak_client"
  }
}

define-command fzf-open-git -docstring 'Pick a file with git' %{
  nop %sh{
    st -e "$kak_config"/scripts/fzf-open-git.sh "$kak_session" "$kak_client"
  }
}

define-command fzf-open-rg -docstring 'Pick a file by content' %{
  nop %sh{
    st -e "$kak_config"/scripts/fzf-open-ripgrep.sh "$kak_session" "$kak_client"
  }
}

define-command lf-open -docstring 'Pick a file with lf' %{
  nop %sh{
    st -e "$kak_config"/scripts/lf-open.sh "$kak_buffile" "$kak_session" "$kak_client"
  }
}

define-command fzf-open-buffer -docstring 'Pick a buffer from kakoune' %{
  # Create a list to store modified status
  declare-option -hidden str-list fzf_buffer_list

  # Clear existing values
  set-option global fzf_buffer_list

  # Build list of buffers and their modified value
  eval -no-hooks -buffer * %{
    set-option -add global fzf_buffer_list "%val{bufname}_%val{modified}"
  }

  # Passing buffer list as multiple parameters to simplify parsing
  nop %sh{
    st -e "$kak_config"/scripts/fzf-open-buffer.sh "$kak_session" "$kak_client" $kak_opt_fzf_buffer_list
  }
}

define-command fzf-delete-buffer -docstring 'Delete a buffer from kakoune' %{
  # Create a list to store modified status
  declare-option -hidden str-list fzf_buffer_list

  # Clear existing values
  set-option global fzf_buffer_list

  # Build list of buffers and their modified value
  eval -no-hooks -buffer * %{
    set-option -add global fzf_buffer_list "%val{bufname}_%val{modified}"
  }

  # Passing buffer list as multiple parameters to simplify parsing
  nop %sh{
    st -e "$kak_config"/scripts/fzf-delete-buffer.sh "$kak_session" "$kak_client" $kak_opt_fzf_buffer_list
  }
}
