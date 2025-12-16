{ pkgs, system }: {
  devShells.${system} = let
    jsPackages = with pkgs; [nodejs yarn nodePackages.typescript-language-server];
    node16 = pkgs2305.nodejs_16;
    yarn16 = pkgs2305.yarn.override { nodejs = node16; };
  in {
    js = pkgs.mkShell {
      name = "Standard JS development";
      buildInputs = jsPackages;
    };

    jsn16 = pkgs.mkShell {
      name = "JS with nodejs v16";
      buildInputs = [node16 yarn16];
    };

    # cypress = pkgs.mkShell {
    #   name = "Cypress (latest) development";
    #   buildInputs = [pkgs.cypress] ++ jsPackages;
    #   shellHook = ''
    #     export NODE_OPTIONS="--openssl-legacy-provider"
    #     export CYPRESS_RUN_BINARY="${pkgs.cypress}/bin/Cypress"
    #   '';
    # };

    reactNative = pkgs.mkShell {
      name = "React native development";
      buildInputs = with pkgs; [
        android-studio
        jdk17
      ] ++ jsPackages;
    };

    clojure = pkgs.mkShell {
      name = "Standard clojure development";
      buildInputs = with pkgs; [
        clojure
        leiningen
      ];
    };

    ocaml = pkgs.mkShell {
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
    };
  };
}
