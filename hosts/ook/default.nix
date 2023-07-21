{ inputs, self, ... }: {
  flake.darwinConfigurations = {
    ook =
      let
        inherit (inputs) darwin nixpkgs;
        inherit (nixpkgs) lib;
        inherit (darwin.lib) darwinSystem;
        system = "aarch64-darwin";
        pkgs = nixpkgs.legacyPackages."${system}";
        workingDirectory = "/var/lib/darwin-builder";
        linuxSystem = builtins.replaceStrings [ "darwin" ] [ "linux" ] system;

        darwin-builder = nixpkgs.lib.nixosSystem {
          system = linuxSystem;
          modules = [
            "${nixpkgs}/nixos/modules/profiles/macos-builder.nix"
            {
              nix = {
                nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
                registry.nixpkgs.flake = inputs.nixpkgs;
              };
              virtualisation.host.pkgs = pkgs;
              virtualisation.darwin-builder.workingDirectory = workingDirectory;
              virtualisation.cores = 4;
              system.nixos.revision = lib.mkForce null;

              system.stateVersion = "23.11";
              boot.binfmt.emulatedSystems = [ "x86_64-linux" ];
            }
          ];
        };

        inherit (import "${self}/home/profiles" inputs) homeImports;

      in
      darwinSystem {
        inherit system;
        modules = [
          inputs.home-manager.darwinModules.home-manager
          {
            nixpkgs.config.packageOverrides = pkgs: {
              nix = pkgs.nixVersions.nix_2_16;
            };
            system.stateVersion = 4;
            programs.fish.enable = true;
            programs.tmux.enable = true;
            security.pam.enableSudoTouchIdAuth = true;
            services.nix-daemon.enable = true;
            nix = {
              nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
              registry.nixpkgs.flake = inputs.nixpkgs;
              settings = {
                auto-optimise-store = true;
                warn-dirty = false;
                experimental-features = "nix-command flakes";
                fallback = true;
                connect-timeout = 5;
                log-lines = 25;
                trusted-users = [ "root" "xanderio" ];
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
              distributedBuilds = true;
              buildMachines = [{
                sshUser = "builder";
                hostName = "linux-builder";
                systems = [
                  linuxSystem
                  "x86_64-linux"
                ];
                maxJobs = 4;
                supportedFeatures = [ ];
                sshKey = "/etc/nix/builder_ed25519";
                protocol = "ssh-ng";
                publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUpCV2N4Yi9CbGFxdDFhdU90RStGOFFVV3JVb3RpQzVxQkorVXVFV2RWQ2Igcm9vdEBuaXhvcwo";
              }];
            };

            launchd.daemons.darwin-builder = {
              command = "${darwin-builder.config.system.build.macos-builder-installer}/bin/create-builder";
              serviceConfig = {
                KeepAlive = true;
                RunAtLoad = true;
                StandardOutPath = "/var/log/darwin-builder.log";
                StandardErrorPath = "/var/log/darwin-builder.log";
              };
            };

            users.users.xanderio = {
              name = "xanderio";
              home = "/Users/xanderio";
            };

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.xanderio.imports = homeImports.ook;
          }
        ];
      };
  };
}
