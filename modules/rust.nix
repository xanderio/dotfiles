{ pkgs, ... }: {
  home = {
    packages = with pkgs; [
      bacon
      dioxus-cli
      cargo-watch
      cargo-edit
      cargo-cache
      cargo-udeps
      cargo-nextest
      cargo-tarpaulin
      cargo-spellcheck
      cargo-espflash
      cargo-espmonitor
    ];

    file.".cargo/config".text = ''
      [build]
      rustc-wrapper = "${pkgs.sccache}/bin/sccache"
      rustdocflags = "--default-theme ayu"

      [target.wasm32-unknown-unknown]
      linker = "wasm-ld"

      [target.x86_64-unknown-linux-gnu]
      linker = "${pkgs.clang}/bin/clang"
      rustflags = ["-C", "link-arg=-fuse-ld=${pkgs.mold}/bin/mold"]

      #[target.x86_64-unknown-linux-gnu]
      #linker = "/usr/bin/clang"
      #rustflags = ["-Clink-arg=-fuse-ld=lld", "-Clink-arg=-Wl,--no-rosegment"]
    '';
  };
}
