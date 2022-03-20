{ inputs }:
{
  meta = {
    nixpkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
    };
  };

  delenn = import ./hosts/delenn;
} 
