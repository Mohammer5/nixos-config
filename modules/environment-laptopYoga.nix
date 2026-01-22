_: let
  baseDir = toString ../.;
in {
  environment.variables.HOSTNAME = "laptopYoga";
  environment.sessionVariables.NIXOS_CONFIG_PATH = baseDir;
}
