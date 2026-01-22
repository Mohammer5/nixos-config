_: let
  baseDir = toString ../.;
in {
  environment.variables.HOSTNAME = "towerGermany";
  environment.sessionVariables.NIXOS_CONFIG_PATH = baseDir;
}
