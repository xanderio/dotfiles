{ inputs }:
{
  meta = {
    nixpkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
    };
  };

  vger = import ./hosts/vger;
} 
