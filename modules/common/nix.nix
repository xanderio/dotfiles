{ inputs, ... }: {
  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    registry.nixpkgs.flake = inputs.nixpkgs;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 10d";
    };
    settings = {
      auto-optimise-store = true;
      warn-dirty = false;
      experimental-features = "nix-command flakes";
      fallback = true;
      connect-timeout = 5;
      log-lines = 25;
      min-free = 128000000;
      max-free = 1000000000;
      
      substituters = [
        "https://nix-community.cachix.org"
        "https://xanderio.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "xanderio.cachix.org-1:MorhZh9LUPDXE0racYZBWb2JQCWmS+r3SQo4zKn51xg="
      ];
    };
  };
  nixpkgs.config.allowUnfree = true;
}
