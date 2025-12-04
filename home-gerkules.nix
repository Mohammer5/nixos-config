{ config, pkgs, lib, ... }: let
  # baseDir = toString ../../.; # cwd = "/home/gerkules/nixos-configuration";
  baseDir = "/home/gerkules/nixos-configuration";
in {
  home = {
    username = "gerkules";
    homeDirectory = "/home/gerkules";
    stateVersion = "23.11";
  };

	home.file = with config.lib.file; {
    # files
    ".config/fish/config.fish".source = mkOutOfStoreSymlink "${baseDir}/config/fish/config.fish";
    ".config/i3/config".source = mkOutOfStoreSymlink "${baseDir}/config/i3/config";
    ".config/kak-lsp/kak-lsp.toml".source = mkOutOfStoreSymlink "${baseDir}/config/kakoune/lsp/kak-lsp.toml";
    ".profile".source = mkOutOfStoreSymlink "${baseDir}/config/.profile";
    ".editorconfig".source = mkOutOfStoreSymlink "${baseDir}/config/.editorconfig";
    ".npmrc".source = mkOutOfStoreSymlink "${baseDir}/config/npm/.npmrc";

    # directories
    ".config/kitty".source = mkOutOfStoreSymlink "${baseDir}/config/kitty";
    ".config/kak".source = mkOutOfStoreSymlink "${baseDir}/config/kakoune";
    ".config/lf".source = mkOutOfStoreSymlink "${baseDir}/config/lf";
  };

  imports = [
    # ./home-gerkules/symlinks.nix
    ./home-gerkules/packages.nix
    ./home-gerkules/git.nix
    ./home-gerkules/mouse.nix
    ./home-gerkules/shell.nix
    ./home-gerkules/test-service.nix
  ];
}
