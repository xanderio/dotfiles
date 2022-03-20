{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs: {
    colmena = import ./hive.nix { inherit inputs; };
  };
}
