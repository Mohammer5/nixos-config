{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages =  with pkgs; let
    myKakoune = pkgs.wrapKakoune pkgs.kakoune-unwrapped {
      configure.plugins = [pkgs.kakounePlugins.parinfer-rust];
    };
  in [
    brave chromium firefox google-chrome tor-browser # browsers
    unzip silver-searcher lf fd st ripgrep zip bat # cli utils
    sublime4 myKakoune kak-lsp logseq # editors
    tdesktop slack zoom-us # social
    editorconfig-core-c
    ledger-live-desktop
    peek flameshot feh # Image-/video-related tools
    transmission
    spotify vlc # sound-related tools
    libnotify
    anki-bin
    kitty
  ];

  programs.neovim = {
    enable = true;
    vimAlias = true;
  };
}
