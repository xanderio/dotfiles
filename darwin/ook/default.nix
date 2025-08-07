{ inputs, self, ... }:
{
  flake.darwinConfigurations = {
    ook =
      let
        inherit (inputs) darwin;
        inherit (darwin.lib) darwinSystem;
        system = "aarch64-darwin";

        inherit (import "${self}/home/profiles" inputs) homeImports;

      in
      darwinSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
        };
        modules = [
          inputs.home-manager.darwinModules.home-manager
          inputs.virby.darwinModules.default
          (
            { pkgs, ... }:
            {
              imports = [ ./libvirt.nix ];
              system.stateVersion = 4;
              programs.fish.enable = true;
              programs.tmux.enable = true;
              security.pam.services.sudo_local = {
                enable = true;
                reattach = true;
                touchIdAuth = true;
                watchIdAuth = true;
              };
              services.virby = {
                enable = true;
                diskSize = "60GiB";
                rosetta = true;
                onDemand = {
                  enable = true;
                  ttl = 15;
                };
                allowUserSsh = true;
                debug = true;
              };
              nix = {
                package = pkgs.lixPackageSets.latest.lix;
                nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
                registry.nixpkgs.flake = inputs.nixpkgs;
                # registry.nixpkgs.to.path = lib.mkForce inputs.nixpkgs.outPath;
                distributedBuilds = true;
                # buildMachines = [
                #   {
                #     sshUser = "xanderio";
                #     hostName = "192.168.66.2";
                #     systems = [
                #       "aarch64-linux"
                #       "x86_64-linux"
                #     ];
                #     maxJobs = 4;
                #     supportedFeatures = [
                #       "big-parallel"
                #       "kvm"
                #     ];
                #     sshKey = "/etc/nix/builder_ed25519";
                #     protocol = "ssh-ng";
                #     publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUdMNEpxUXVvTEJKaTRYa1Rab0k5SFhoM2o2dEM1M0luYTJiYU1BMi96MWMK";
                #   }
                # ];
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
                    "https://virby-nix-darwin.cachix.org"
                  ];
                  trusted-public-keys = [
                    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
                    "xanderio.cachix.org-1:MorhZh9LUPDXE0racYZBWb2JQCWmS+r3SQo4zKn51xg="
                    "virby-nix-darwin.cachix.org-1:z9GiEZeBU5bEeoDQjyfHPMGPBaIQJOOvYOOjGMKIlLo="
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
          )
        ];
      };
  };
}
