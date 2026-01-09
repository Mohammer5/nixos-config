{ pkgs }:
pkgs.mkShell {
  packages = [
    pkgs.nodejs
    pkgs.steam-run
    pkgs.nss
    pkgs.nspr
    (pkgs.writeShellScriptBin "cy" ''
      # This runs when you type `cy ...` inside `nix develop .#cypress`
      exec ${pkgs.steam-run}/bin/steam-run bash -lc '
        # We are now *inside* the steam runtime; extend its LD_LIBRARY_PATH
        export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${pkgs.nspr}/lib:${pkgs.nss}/lib"
        exec npx cypress "$@"
      ' cy "$@"
    '')
  ];

  shellHook = ''
    echo
    echo "Cypress dev shell:"
    echo "Use:"
    echo "-  cy install"
    echo "-  cy run"
    echo "-  cy open"
    echo
  '';
}
