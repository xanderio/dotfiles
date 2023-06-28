{ inputs, ... }: {
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
              virtualisation.host.pkgs = pkgs;
              virtualisation.darwin-builder.workingDirectory = workingDirectory;
              system.nixos.revision = lib.mkForce null;

              boot.binfmt.emulatedSystems = [ "x86_64-linux" ];
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
            nix.settings = {
              experimental-features = "nix-command flakes";
              auto-optimise-store = true;
              sandbox = true;
              extra-trusted-users = [ "xanderio" ];
              builders-use-substitutes = true;
              extra-nix-path = "nixpkgs=flake:nixpkgs";
            };
            nix.distributedBuilds = true;
            nix.buildMachines = [{
              sshUser = "builder";
              hostName = "localhost";
              systems = [
                linuxSystem
                "x86_64-linux"
              ];
              maxJobs = 4;
              supportedFeatures = [ "kvm" "benchmark" "big-parallel" ];
              sshKey = "/etc/nix/builder_ed25519";
              protocol = "ssh-ng";
              publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUpCV2N4Yi9CbGFxdDFhdU90RStGOFFVV3JVb3RpQzVxQkorVXVFV2RWQ2Igcm9vdEBuaXhvcwo";
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
