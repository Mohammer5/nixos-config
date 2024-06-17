{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages =  with pkgs; let
    myKakoune = pkgs.wrapKakoune pkgs.kakoune-unwrapped {
      configure.plugins = [pkgs.kakounePlugins.parinfer-rust];
    };
  in [
    nodejs yarn nodePackages.typescript-language-server cypress # JS
    kitty unzip silver-searcher lf fd st ripgrep zip bat renameutils # cli utils
    brave chromium firefox google-chrome tor-browser # browsers
    sublime4 myKakoune kak-lsp logseq # editors
    tdesktop slack zoom-us # social
    editorconfig-core-c
    ledger-live-desktop
    peek flameshot feh # Image-/video-related tools
    clojure leiningen # clojure
    transmission
    spotify vlc # sound-related tools
    libnotify
    anki-bin

    php
    php83Packages.composer
  ];

  programs.neovim = {
    enable = true;
    vimAlias = true;
  };
}
