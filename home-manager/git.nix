{ config, pkgs, lib, ... }: {
  programs.git = {
    enable = true;
    ignores = import ../config/git/gitignore_global.nix;
    aliases = import ../config/git/aliases.nix;

    # default user information
    userName = "Mohammer5";
    userEmail = "jgs.salomon@gmail.com";

    # conditional user information overrides
    includes = [
      { path = builtins.toString ../config/git/gpg-key.gitconfig; }
      {
        condition = "gitdir:~/development/dhis2/";
        contents.user = {
          name = "Mohammer5";
          email = "jan-gerke@dhis2.org";
        };
      }
    ];
  };
}
