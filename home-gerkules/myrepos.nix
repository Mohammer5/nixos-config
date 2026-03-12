{ lib, pkgs, devBaseDir, ... }: let
  parentDirs = [
    "bf2c"
    "compaire"
    "interactive-pioneers"
    "interactive-pioneers/bim"
    "interactive-pioneers/easyrent"
    "interactive-pioneers/henkel"
    "interactive-pioneers/ip"
    "interactive-pioneers/plusnet"
    "interactive-pioneers/porsche"
    "interactive-pioneers/reitwm"
    "interactive-pioneers/rwthc"
    "interactive-pioneers/st24"
    "neues-projekt"
    "neues-projekt/.ai-instructions"
    "others"
    "others/dhis2"
    "others/ismay"
    "personal"
    "personal/facefusion"
    "personal/my-app"
  ];
in {
  home.activation.myreposBootstrap = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    export DEV_BASE_DIR=${lib.escapeShellArg devBaseDir}
    config_file="$HOME/.mrconfig"

    for rel_dir in ${lib.concatStringsSep " " (map lib.escapeShellArg parentDirs)}; do
      $DRY_RUN_CMD mkdir -p "$DEV_BASE_DIR/$rel_dir"
    done

    if [ -f "$config_file" ]; then
      $DRY_RUN_CMD ${pkgs.mr}/bin/mr -c "$config_file" checkout
    fi
  '';
}
