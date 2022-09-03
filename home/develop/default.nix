{ pkgs, ... }: {
  imports = [
    ./neovim
  ];
  home = {
    packages = with pkgs; [
      # rust
      bacon
      cargo-watch
      cargo-edit
      cargo-cache
      cargo-udeps
      cargo-nextest
      cargo-tarpaulin
      cargo-spellcheck
      dioxus-cli
      cargo-espflash
      cargo-espmonitor

      darcs
    ];

    sessionVariables = {
      DARCS_ALWAYS_COLOR = "1";
      DARCS_ALTERNATIVE_COLOR = "1";
      DARCS_DO_COLOR_LINES = "1";
    };

    file.".cargo/config".text = ''
      [build]
      rustc-wrapper = "${pkgs.sccache}/bin/sccache"
      rustdocflags = "--default-theme ayu"

      [target.wasm32-unknown-unknown]
      linker = "wasm-ld"

      [target.x86_64-unknown-linux-gnu]
      linker = "${pkgs.clang}/bin/clang"
      rustflags = ["-C", "link-arg=-fuse-ld=${pkgs.mold}/bin/mold"]
    '';
  };
}
