{ options, config, pkgs, ... }: {
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        efiSupport = true;
        enable = true;
        devices = [ "nodev" ];
        useOSProber = true;
      };
    };
  };

  time.timeZone = "Europe/Berlin";
  # time.timeZone = "Asia/Manila";
  services.localtimed.enable = false;
  i18n.defaultLocale = "en_US.UTF-8";

  fonts.packages = [
    pkgs.dejavu_fonts
    # pkgs.nerdfonts
  ] ++ builtins.filter pkgs.lib.attrsets.isDerivation
      (builtins.attrValues pkgs.nerd-fonts);

  networking.extraHosts = ''
    127.0.0.1 porsche-roads-website.localhost.direct
  '';

  programs.fish.enable = true;
  # programs.fish.shellAliases = import ./modules/shell-aliases.nix;
  # programs.bash.shellAliases = import ./modules/shell-aliases.nix;
  programs.gnupg.agent.enable = true;

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "gerkules" ];

  users.users.gerkules = {
    isNormalUser = true;
    description = "Gerkules";
    extraGroups = [ "audio" "networkmanager" "wheel" "docker" "plugdev" "scanner" "lp" ];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };

  virtualisation.docker.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  hardware.enableAllFirmware  = true;
  nixpkgs.config.permittedInsecurePackages = ["electron-13.6.9" "openssl-1.1.1w"];

  services.logind.lidSwitchExternalPower = "ignore";
  services.teamviewer.enable = true;
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
