{ pkgs }:
let
  php = pkgs.php84.withExtensions ({ all, ... }: with all; [
    curl
    dom
    exif
    fileinfo
    gd
    imagick
    intl
    mbstring
    mysqli
    openssl
    pdo
    pdo_mysql
    pdo_sqlite
    simplexml
    tokenizer
    xml
    xmlreader
    xmlwriter
    zip
    sodium
    sockets
  ]);
in
pkgs.mkShell {
  packages = [
    php
    pkgs.php84Packages.composer
  ];
}
