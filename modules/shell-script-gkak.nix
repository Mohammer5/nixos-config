{ pkgs, ... }:

let
  gkak = pkgs.writeShellScriptBin "gkak" ''
    session_name=$(git remote get-url origin 2> /dev/null | cut -d ":" -f2 | sed "s/\(.*\)[.]git\$/\1/" | sed "s/\//-/")

    if [ "$session_name" ]; then
      kak -c "$session_name" "$@" || kak -s "$session_name" "$@"
    else
      kak "$@"
    fi
  '';
in {
  environment.systemPackages = [ gkak ];
}
