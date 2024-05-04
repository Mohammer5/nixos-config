{ ... }: {
  programs = {
    home-manager.enable = true;
    bash.shellAliases = import ./modules/shell-aliases.nix;
  };
}
