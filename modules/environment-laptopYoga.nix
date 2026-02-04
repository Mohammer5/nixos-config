_: let
  baseDir = toString ../.;
in {
  environment.variables.HOSTNAME = "laptopYoga";
  environment.sessionVariables.NIXOS_CONFIG_PATH = baseDir;
  environment.sessionVariables.DEV_BASE_DIR = "/home/gerkules/development";

  home-manager.extraSpecialArgs = {
    devBaseDir = "/home/gerkules/development";
  };
}
