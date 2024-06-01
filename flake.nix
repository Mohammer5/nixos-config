{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    nixpkgs2305.url = github:NixOS/nixpkgs/23.05;
    nixpkgsNode14.url = github:NixOS/nixpkgs/f21b6f77ac562732a4c9b8d1e5751c97853fe873;

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs2305, nixpkgsNode14, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    pkgs2305 = (import nixpkgs2305 {
      inherit system;
      config.permittedInsecurePackages = ["nodejs-16.20.0"];
    });
    pkgsNode14 = (import nixpkgsNode14 {
      inherit system;
    });
  in {
    nixosConfigurations = {
      laptopYoga = nixpkgs.lib.nixosSystem {
        inherit system;

        # environment.systemPackages = [
        #   nixpkgsTeams.legacyPackages.${system}.teams
        # ];

        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
          ./modules/xserver.nix
          ./modules/environment-laptopYoga.nix
          ./modules/audio.nix
          ./modules/networking.nix
          ./modules/systemPackages.nix
          ./modules/yoga-laptop-hardware.nix
          ./modules/direnv.nix
          ./modules/systemState.nix
          ./modules/udev.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.gerkules = import ./home-gerkules.nix;
          }
        ];
      };
    };

    devShells.${system} = let
      jsPackages = with pkgs; [nodejs yarn nodePackages.typescript-language-server];
    in {
      jsn16 = (import ./devShells/jsn16.nix { inherit pkgs pkgs2305; });
      jsn14 = (import ./devShells/jsn14.nix { inherit pkgs pkgsNode14; });
      reactNative = (import ./devShells/reactNative.nix { inherit pkgs jsPackages; });
      ocaml = (import ./devShells/ocaml.nix { inherit pkgs; });

      # ----> The packages for these are installed by default <----
      # ###########################################################
      #
      # js = import ./devShells/js.nix { inherit jsPackages; };
      # cypress = (import ./devShells/cypress.nix { inherit pkgs jsPackages; });
      # clojure = (import ./devShells/clojure.nix { inherit pkgs; });
    };
  };
}
