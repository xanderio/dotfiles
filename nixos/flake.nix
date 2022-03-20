{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
  };

  outputs = inputs: {
    colmena = import ./hive.nix { inherit inputs; };
  };
}
