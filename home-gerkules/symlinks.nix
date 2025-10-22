{ config, ... }: {
	home.file = with config.lib.file; let
    # configDirectory = builtins.toString ../config;
    configDirectory = "/home/gerkules/nixos-configuration/config";
  in {
    # files
    ".config/i3/config".source = mkOutOfStoreSymlink "${configDirectory}/i3/config";
    ".config/kak-lsp/kak-lsp.toml".source = mkOutOfStoreSymlink "${configDirectory}/kakoune/lsp/kak-lsp.toml";
    ".profile".source = mkOutOfStoreSymlink "${configDirectory}/.profile";
    ".editorconfig".source = mkOutOfStoreSymlink "${configDirectory}/.editorconfig";

    # directories
    ".config/fish".source = mkOutOfStoreSymlink "${configDirectory}/fish";
    ".config/kitty".source = mkOutOfStoreSymlink "${configDirectory}/kitty";
    ".config/kak".source = mkOutOfStoreSymlink "${configDirectory}/kakoune";
    ".config/lf".source = mkOutOfStoreSymlink "${configDirectory}/lf";
  };
}
