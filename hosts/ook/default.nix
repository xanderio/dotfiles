{ inputs, ... }: {
  flake.darwinConfigurations = {
    ook =
      let
        inherit (inputs) darwin nixpkgs;
        inherit (nixpkgs) lib;
        inherit (darwin.lib) darwinSystem;
        system = "aarch64-darwin";
        pkgs = nixpkgs.legacyPackages."${system}";
        linuxSystem = builtins.replaceStrings [ "darwin" ] [ "linux" ] system;

        darwin-builder = nixpkgs.lib.nixosSystem {
          system = linuxSystem;
          modules = [
            "${nixpkgs}/nixos/modules/profiles/macos-builder.nix"
            {
              virtualisation.host.pkgs = pkgs;
              system.nixos.revision = lib.mkForce null;
            }
          ];
        };
      in
      darwinSystem {
        inherit system;
        modules = [
          {
            system.stateVersion = 4;
            programs.fish.enable = true;
            services.nix-daemon.enable = true;
            nix.settings.experimental-features = "nix-command flakes";
            nix.distributedBuilds = true;
            nix.buildMachines = [{
              hostName = "ssh://builder@localhost";
              system = linuxSystem;
              maxJobs = 4;
              supportedFeatures = [ "kvm" "benchmark" "big-parallel" ];
            }];

            launchd.daemons.darwin-builder = {
              command = "${darwin-builder.config.system.build.macos-builder-installer}/bin/create-builder";
              serviceConfig = {
                KeepAlive = true;
                RunAtLoad = true;
                StandardOutPath = "/var/log/darwin-builder.log";
                StandardErrorPath = "/var/log/darwin-builder.log";
              };
            };
          }
        ];
      };
  };
}
