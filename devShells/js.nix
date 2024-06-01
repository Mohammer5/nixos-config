{ jsPackages }: pkgs.mkShell {
  name = "Standard JS development";
  buildInputs = jsPackages;
}
