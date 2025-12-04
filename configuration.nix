{ options, config, pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "steam-unwrapped"  # narrow allowlist
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

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
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  hardware.enableAllFirmware  = true;
  nixpkgs.config.permittedInsecurePackages = ["electron-13.6.9" "openssl-1.1.1w"];

  services.logind.settings.Login.HandleLidSwitchExternalPower = "ignore";
  services.teamviewer.enable = true;
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # for lando
  security.pki.certificateFiles = [
    ./certs/lando-local-ca.crt
  ];
  networking.hosts = let
    landoSites = [
      "radicle.lndo.site" # IP radicle base repo
      "rwthcampus.lndo.site"
      "reit-wm-2026.lndo.site"
      "website.localhost.direct" # Easyrent
      "easy-rent-website.localhost.direct" # Easyrent
      "porsche-roads-website.localhost.direct"
    ];
  in {
    "127.0.0.1" = landoSites;
    "127.0.0.2" = landoSites;
  };
}
