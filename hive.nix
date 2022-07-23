{ inputs
, overlays
,
}: {
  meta = {
    specialArgs = {
      inherit inputs;
      nixpkgs = inputs.nixpkgs;
    };
    nixpkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
      inherit overlays;
    };
  };

  delenn = import ./hosts/delenn;
  valen = import ./hosts/valen;
  block = import ./hosts/block;
}
