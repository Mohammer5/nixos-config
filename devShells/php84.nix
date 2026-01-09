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
    simplexml
    xml
    xmlreader
    xmlwriter
    zip
    sodium
  ]);
in
pkgs.mkShell {
  packages = [
    php
    pkgs.php84Packages.composer
  ];
}
