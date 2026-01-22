{ pkgs, ... }: {
  # nixpkgs.config.allowUnfree = true;

  home.packages =  with pkgs; let
    myKakoune = pkgs.wrapKakoune pkgs.kakoune-unwrapped {
      configure.plugins = [pkgs.kakounePlugins.parinfer-rust];
    };

    chromiumWithFlags = pkgs.symlinkJoin {
      name = "chromium-with-remote-debug";
      paths = [ pkgs.chromium ];
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/chromium \
          --add-flags "--remote-debugging-port=9222"
      '';
    };
  in [
    nodejs_24 yarn nodePackages.typescript-language-server # JS
    kitty usbutils
    unzip silver-searcher lf fd st ripgrep zip bat # renameutils # cli utils
    brave chromiumWithFlags firefox tor-browser # opera google-chrome # browsers
    sublime4 myKakoune kakoune-lsp logseq postman # editors
    telegram-desktop slack zoom-us signal-desktop # social
    editorconfig-core-c poppler-utils file imagemagick
    ledger-live-desktop trezor-suite
    peek flameshot feh # Image-/video-related tools
    clojure leiningen # clojure
    transmission_4 stockfish
    spotify vlc # sound-related tools
    libnotify
    anki-bin
    obs-studio
    expressvpn
    xcolor
  ];

  programs.neovim = {
    enable = true;
    vimAlias = true;
  };
}
