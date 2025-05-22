{
  pkgs,
  inputs,
  ...
}:
let
  neovim = inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.neovim.extend {
    nixpkgs.pkgs = pkgs;
  };
in
{
  home = {
    packages =
      (with pkgs; [
        nix-update
        nix-init
        glab
        gh
        nix-fast-build
        hydra-check
      ])
      ++ [
        inputs.nixpkgs-review.packages.${pkgs.stdenv.hostPlatform.system}.nixpkgs-review
        neovim
      ]
      ++ neovim.config.extraPackages;

    sessionVariables = {
      DARCS_ALWAYS_COLOR = "1";
      DARCS_ALTERNATIVE_COLOR = "1";
      DARCS_DO_COLOR_LINES = "1";
      ERL_AFLAGS = "-kernel shell_history enabled";
      EDITOR = "nvim";
    };

    file.".cargo/config.toml".text =
      ''
        [build]
        rustc-wrapper = "${pkgs.sccache}/bin/sccache"
        rustdocflags = "--default-theme ayu"

        [target.wasm32-unknown-unknown]
        linker = "wasm-ld"
      '';
  };

  xdg.configFile."pgcli/config".source = ./pgcli/config;
}
