{ config, pkgs, lib, ... }: let
    cwd = "/nixos-config";
in {
  home = {
    username = "gerkules";
    homeDirectory = "/home/gerkules";
    stateVersion = "23.11";
  };

	home.file = with config.lib.file; {
    # files
    ".config/fish/config.fish".source = mkOutOfStoreSymlink "${cwd}/config/fish/config.fish";
    ".config/i3/config".source = mkOutOfStoreSymlink "${cwd}/config/i3/config";
    ".config/kak-lsp/kak-lsp.toml".source = mkOutOfStoreSymlink "${cwd}/config/kakoune/lsp/kak-lsp.toml";
    ".profile".source = mkOutOfStoreSymlink "${cwd}/config/.profile";
    ".editorconfig".source = mkOutOfStoreSymlink "${cwd}/config/.editorconfig";
    ".npmrc".source = mkOutOfStoreSymlink "${cwd}/config/npm/.npmrc";

    # directories
    ".config/kitty".source = mkOutOfStoreSymlink "${cwd}/config/kitty";
    ".config/kak".source = mkOutOfStoreSymlink "${cwd}/config/kakoune";
    ".config/lf".source = mkOutOfStoreSymlink "${cwd}/config/lf";
  };

  imports = [
    ./home-gerkules/packages.nix
    ./home-gerkules/git.nix
    # ./home-gerkules/symlinks.nix
    ./home-gerkules/mouse.nix
    ./home-gerkules/shell.nix
    ./home-gerkules/test-service.nix
  ];
}
