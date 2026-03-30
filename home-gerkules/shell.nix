{ config, ... }: {
  programs = {
    home-manager.enable = true;
    bash.shellAliases = import ../../modules/shell-aliases.nix;
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.npm/bin"
  ];
}
