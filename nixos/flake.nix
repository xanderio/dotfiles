{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs:
    inputs.flake-utils.lib.eachDefaultSystem
      (system:
        let pkgs = inputs.nixpkgs.legacyPackages.${system}; in
        {
          devShell = pkgs.mkShellNoCC {
            buildInputs = with pkgs; [ colmena ];
          };
        }) // {
      colmena = import ./hive.nix { inherit inputs; };
    };
}
