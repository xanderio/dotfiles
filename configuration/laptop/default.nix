{ ... }:
{
  imports = [
    ./boot.nix
    ./cachix.nix
    ./desktop.nix
    ./firewall.nix
    ./fonts.nix
    ./users.nix
    ./services.nix
  ];
}
