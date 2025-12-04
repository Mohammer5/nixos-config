{ config, pkgs, lib, ... }: {
  programs.git = {
    enable = true;
    ignores = import ../config/git/gitignore_global.nix;
    aliases = import ../config/git/aliases.nix;

    settings = {
      # default user information
      user.name = "Mohammer5";
      user.email = "jgs.salomon@gmail.com";
      init.defaultBranch = "main";
    };

    # conditional user information overrides
    includes = [
      {
        condition = "gitdir:/mnt/ssd/development/interactive-pioneers/";
        contents.user = {
          name = "Jan-Gerke Salomon";
          email = "jgs@interactive-pioneers.de";
        };
      }
    ];

    # # conditional user information overrides
    # includes = [
    #   { path = builtins.toString ../config/git/gpg-key.gitconfig; }
    #   {
    #     condition = "gitdir:~/development/dhis2/";
    #     contents.user = {
    #       name = "Mohammer5";
    #       email = "jan-gerke@dhis2.org";
    #     };
    #   }
    # ];

    # Add the safe directory configuration
    # extraConfig = ''
    #   [safe]
    #     directory = "/home/gerkules/development/interactive-pioneers/porsche-roads-website"
    # '';
  };
}
