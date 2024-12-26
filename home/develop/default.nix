{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  home = {
    packages =
      (with pkgs; [
        nix-update
        nix-init
        glab
        gh
        nix-fast-build
      ]) ++ [ 
        inputs.nixpkgs-review.packages.${pkgs.stdenv.hostPlatform.system}.nixpkgs-review 
        inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.neovim
      ];

    sessionVariables = {
      DARCS_ALWAYS_COLOR = "1";
      DARCS_ALTERNATIVE_COLOR = "1";
      DARCS_DO_COLOR_LINES = "1";
      ERL_AFLAGS = "-kernel shell_history enabled";
    };

    file.".cargo/config.toml".text =
      let
        bintools-wrapper = "${pkgs.path}/pkgs/build-support/bintools-wrapper";
        mold' = pkgs.symlinkJoin {
          name = "mold";
          paths = [ pkgs.mold ];
          nativeBuildInputs = [ pkgs.makeWrapper ];
          suffixSalt =
            lib.replaceStrings
              [
                "-"
                "."
              ]
              [
                "_"
                "_"
              ]
              pkgs.stdenv.targetPlatform.config;
          postBuild = ''
            for bin in ${pkgs.mold}/bin/*; do
              rm $out/bin/"$(basename "$bin")"

              export prog="$bin"
              substituteAll "${bintools-wrapper}/ld-wrapper.sh" $out/bin/"$(basename "$bin")"
              chmod +x $out/bin/"$(basename "$bin")"

              mkdir -p $out/nix-support
              substituteAll "${bintools-wrapper}/add-flags.sh" $out/nix-support/add-flags.sh
              substituteAll "${bintools-wrapper}/add-hardening.sh" $out/nix-support/add-hardening.sh
              substituteAll "${bintools-wrapper}/../wrapper-common/utils.bash" $out/nix-support/utils.bash
            done
          '';
        };
      in
      ''
        [build]
        rustc-wrapper = "${pkgs.sccache}/bin/sccache"
        rustdocflags = "--default-theme ayu"

        [target.wasm32-unknown-unknown]
        linker = "wasm-ld"

        [target.x86_64-unknown-linux-gnu]
        linker = "${pkgs.clang}/bin/clang"
        rustflags = ["-C", "link-arg=-fuse-ld=${mold'}/bin/mold"]
      '';
  };

  xdg.configFile."pgcli/config".source = ./pgcli/config;
}
