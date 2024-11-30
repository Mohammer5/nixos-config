{ config, pkgs, lib, ... }: {
  programs.git = {
    enable = true;
    ignores = import ../config/git/gitignore_global.nix;
    aliases = import ../config/git/aliases.nix;

    # default user information
    userName = "Mohammer5";
    userEmail = "jgs.salomon@gmail.com";

    # This is for signing commits, which I only needed for dhis2
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
