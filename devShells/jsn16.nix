{ pkgs, pkgs2305 }: let
  node16 = pkgs2305.nodejs_16;
  yarn16 = pkgs2305.yarn.override { nodejs = node16; };
in pkgs.mkShell {
  name = "JS with nodejs v16";
  buildInputs = [
    node16
    yarn16
    pkgs.nodePackages.typescript-language-server
  ];
}
