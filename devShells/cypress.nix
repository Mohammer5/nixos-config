{ pkgs, jsPackages }: pkgs.mkShell {
  name = "Cypress (latest) development";
  buildInputs = [pkgs.cypress ] ++ jsPackages;
  shellHook = ''
    export NODE_OPTIONS="--openssl-legacy-provider"
    export CYPRESS_RUN_BINARY="${pkgs.cypress}/bin/Cypress"
  '';
}
