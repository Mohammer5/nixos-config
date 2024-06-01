{ pkgs, pkgsNode14 }: pkgs.mkShell {
  name = "JS with nodejs v14";
  buildInputs = with pkgsNode14; [
    nodejs
    yarn
  ];
}
