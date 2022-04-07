{ pkgs ? import <nixpkgs> { } }:
with pkgs;
mkShellNoCC {
  buildInputs = [
    colmena
  ];
}
