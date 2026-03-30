{ pkgs, ... }:

let
  gkak = pkgs.writeShellScriptBin "gkak" ''
    raw_session_name=$(git remote get-url origin 2> /dev/null | cut -d ":" -f2 | sed "s/\(.*\)[.]git\$/\1/" | sed "s/\//-/")
    session_name=$(
      printf '%s' "$raw_session_name" \
        | tr '[:upper:]' '[:lower:]' \
        | sed 's/[^a-z0-9_-]/-/g; s/--*/-/g; s/^[-_]*//; s/[-_]*$//'
    )

    if [ "$session_name" ]; then
      kak -c "$session_name" "$@" || kak -s "$session_name" "$@"
    else
      kak "$@"
    fi
  '';
in {
  environment.systemPackages = [ gkak ];
}
