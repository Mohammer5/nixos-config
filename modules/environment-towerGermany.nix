_: let
  baseDir = toString ../.;
in {
  environment.sessionVariables.NIXOS_CONFIG_PATH = baseDir;
}
