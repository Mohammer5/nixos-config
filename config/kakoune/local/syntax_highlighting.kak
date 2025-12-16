# GraphQL syntax highlighting
hook global BufCreate .*\.gql$ %{
    set-option buffer filetype graphql
}

hook global BufCreate .*\.graphql$ %{
    set-option buffer filetype graphql
}
