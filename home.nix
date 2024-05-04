{ config, pkgs, lib, ... }: {
  home = {
    username = "gerkules";
    homeDirectory = "/home/gerkules";
    stateVersion = "23.11";
  };

  imports = [
    ./home-gerkules/packages.nix
    ./home-gerkules/git.nix
    ./home-gerkules/symlinks.nix
    ./home-gerkules/mouse.nix
    ./home-gerkules/shell.nix
  ];
}
