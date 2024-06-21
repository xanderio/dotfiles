{ inputs, self, ... }:
{
  flake.darwinConfigurations = {
    ook =
      let
        inherit (inputs) darwin nixpkgs;
        inherit (nixpkgs) lib;
        inherit (darwin.lib) darwinSystem;
        system = "aarch64-darwin";
        pkgs = nixpkgs.legacyPackages."${system}";

        inherit (import "${self}/home/profiles" inputs) homeImports;

      in
      darwinSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
        };
        modules = [
          inputs.home-manager.darwinModules.home-manager
          {
            system.stateVersion = 4;
            programs.fish.enable = true;
            programs.tmux.enable = true;
            security.pam.enableSudoTouchIdAuth = true;
            services.nix-daemon.enable = true;
            nix = {
              package = pkgs.lix;
              nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
              registry.nixpkgs.flake = inputs.nixpkgs;
              linux-builder = {
                enable = true;

                systems = [ "x86_64-linux" "aarch64-linux" ];

                config = {
                  nix = {
                    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
                    registry.nixpkgs.flake = inputs.nixpkgs;
                    gc = {
                      automatic = true;
                      dates = "hourly";
                      persistent = false;
                    };
                  };
                  virtualisation.cores = 4;
                  virtualisation.memorySize = lib.mkForce (1024 * 8);
                  # system.nixos.revision = lib.mkForce null;
                  #
                  # system.stateVersion = "23.11";
                  boot.binfmt.emulatedSystems = [ "x86_64-linux" ];
                };
              };
              settings = {
                auto-optimise-store = false;
                warn-dirty = false;
                experimental-features = "nix-command flakes";
                fallback = true;
                connect-timeout = 5;
                log-lines = 25;
                trusted-users = [
                  "root"
                  "xanderio"
                ];
                builders-use-substitutes = true;

                substituters = [
                  "https://nix-community.cachix.org"
                  "https://xanderio.cachix.org"
                ];
                trusted-public-keys = [
                  "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
                  "xanderio.cachix.org-1:MorhZh9LUPDXE0racYZBWb2JQCWmS+r3SQo4zKn51xg="
                ];
              };
            };

            environment.shellAliases = {
              "tailscale" = "/Applications/Tailscale.app/Contents/MacOS/Tailscale";
            };

            users.users.xanderio = {
              name = "xanderio";
              home = "/Users/xanderio";
            };

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
            home-manager.users.xanderio.imports = homeImports.ook;
          }
        ];
      };
  };
}
