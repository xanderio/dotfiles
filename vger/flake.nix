{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = { self, nixpkgs, nixos-hardware, ... }@inputs: {
    # replace 'joes-desktop' with your hostname here.
    nixosConfigurations.vger = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = inputs;
      modules = [
        ./configuration.nix
        nixos-hardware.nixosModules.lenovo-thinkpad-t480s
      ];
    };
  };
}
