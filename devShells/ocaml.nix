{ pkgs }: pkgs.mkShell {
  name = "Standard OCAML development";
  buildInputs = with pkgs; [
    ocaml
    ocamlPackages.findlib
    dune_2
    ocamlPackages.ocaml-lsp
    ocamlformat
    ocamlPackages.ocamlformat-rpc-lib
    ocamlPackages.utop
    ocamlPackages.re
    mpv
    opam
  ];
}
