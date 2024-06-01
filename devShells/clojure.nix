{ pkgs }: pkgs.mkShell {
  name = "Standard clojure development";
  buildInputs = with pkgs; [ clojure leiningen ];
}
