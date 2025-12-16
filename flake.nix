{
  description = "Jan-Gerke's NixOS config";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;  # or use the predicate below
    };

    mkHost = extraModules: nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit system;
        username = "gerkules";
      };

      modules = extraModules ++ [
        ./configuration.nix
        ./modules/additional-harddrives.nix
        ./modules/xserver.nix
        ./modules/audio.nix
        ./modules/systemPackages.nix
        ./modules/yoga-laptop-hardware.nix
        ./modules/direnv.nix
        ./modules/systemState.nix
        ./modules/udev.nix
        ./modules/libvert.nix
        ./modules/shell-script-gkak.nix
        ./modules/samba.nix

        # Home manager configuration
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.gerkules = import ./home-gerkules.nix;
        }
      ];
    };
  in {
    nixosConfigurations = {
      towerGermany = mkHost [
        ./modules/hardware-configuration-tower-germany.nix
        # ./modules/environment-towerGermany.nix
        # ./modules/networking-towerGermany.nix
        ./modules/environment-laptopYoga.nix
        ./modules/networking-laptopYoga.nix
      ];

      laptopYoga = mkHost [
        # @TODO
        # ./modules/hardware-configuration-tower-germany.nix
        ./modules/environment-laptopYoga.nix
        ./modules/networking-laptopYoga.nix
      ];
    };

    devShells.${system} = let
      jsPackages = with pkgs; [nodejs yarn nodePackages.typescript-language-server];
    in {
      cypress = pkgs.mkShell {
        packages = [
          pkgs.nodejs
          pkgs.steam-run
          pkgs.nss
          pkgs.nspr
          (pkgs.writeShellScriptBin "cy" ''
            # This runs when you type `cy ...` inside `nix develop .#cypress`
            exec ${pkgs.steam-run}/bin/steam-run bash -lc '
              # We are now *inside* the steam runtime; extend its LD_LIBRARY_PATH
              export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${pkgs.nspr}/lib:${pkgs.nss}/lib"
              exec npx cypress "$@"
            ' cy "$@"
          '')
        ];

        shellHook = ''
          echo
          echo "Cypress dev shell:"
          echo "Use:"
          echo "-  cy install"
          echo "-  cy run"
          echo "-  cy open"
          echo
        '';
      };
    };
  };
}
