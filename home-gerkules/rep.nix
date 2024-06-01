{ config, lib, pkgs, ... }: pkgs.stdenv.mkDerivation rec {
    pname = "rep";
    version = "commit_or_tag";  # Replace commit_or_tag with the actual commit hash or tag

    src = pkgs.fetchFromGitHub {
      owner = "eraserhd";
      repo = "rep";
      rev = "1b5321ef5628270cb391fc7dd3c19259f5931c03";
      sha256 = "0000000000000000000000000000000000000000000000000000";  # Replace this with the correct hash
    };

    buildInputs = with pkgs; [ gnumake ];
    buildPhase = "make";
    installPhase = ''
      mkdir -p $out/bin
      cp rep $out/bin/
    '';
  };
