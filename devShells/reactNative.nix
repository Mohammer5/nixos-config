{ pkgs, jsPackages }: pkgs.mkShell {
  name = "React native development";
  buildInputs = with pkgs; [
    android-studio
    jdk17
  ] ++ jsPackages;
}
