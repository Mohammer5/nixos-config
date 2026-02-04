_: let
  baseDir = toString ../.;
in {
  environment.variables.HOSTNAME = "towerGermany";
  environment.sessionVariables.NIXOS_CONFIG_PATH = baseDir;
  environment.sessionVariables.DEV_BASE_DIR = "/mnt/ssd/development";

  home-manager.extraSpecialArgs = {
    devBaseDir = "/mnt/ssd/development";
  };
}
