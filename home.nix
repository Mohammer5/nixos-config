{ config, pkgs, lib, ... }: {
  imports = [
    ./home-manager/packages.nix
    ./home-manager/git.nix
  ];

  nixpkgs.config.allowUnfree = true;

  programs = {
    home-manager.enable = true;
    bash.shellAliases = import ./modules/shell-aliases.nix;
  };

  home = {
    username = "gerkules";
    homeDirectory = "/home/gerkules";

    pointerCursor = {
      x11.enable = true;
      name = "DMZ-White";
      package = pkgs.vanilla-dmz;
      size = 40;
      gtk.enable = true;
    };

		file = with config.lib.file; let
	    configDirectory = builtins.toString ./config;
    in {
      # files
      ".config/fish/config.fish".source = mkOutOfStoreSymlink "${configDirectory}/fish/config.fish";
      ".config/i3/config".source = mkOutOfStoreSymlink "${configDirectory}/i3/config";
      ".config/kak-lsp/kak-lsp.toml".source = mkOutOfStoreSymlink "${configDirectory}/kakoune/lsp/kak-lsp.toml";
      ".profile".source = mkOutOfStoreSymlink "${configDirectory}/.profile";
      ".editorconfig".source = mkOutOfStoreSymlink "${configDirectory}/.editorconfig";

      # directories
      ".config/kitty".source = mkOutOfStoreSymlink "${configDirectory}/kitty";
      ".config/kak".source = mkOutOfStoreSymlink "${configDirectory}/kakoune";
      ".config/lf".source = mkOutOfStoreSymlink "${configDirectory}/lf";
    };

    stateVersion = "23.11";
  };
}
