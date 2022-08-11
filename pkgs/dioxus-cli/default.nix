{ lib
, rustPlatform
, pkgs
, openssl
, pkg-config
,
}:
rustPlatform.buildRustPackage {
  pname = "dioxus-cli";
  version = "1.0.0";

  src = builtins.fetchTarball {
    url = "https://crates.io/api/v1/crates/dioxus-cli/0.1.4/download";
    sha256 = "1flw2zn5z8b5xpmpn2h6apvr63ncnrkcw3m9bx5pzyswrhw86yaa";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  cargoSha256 = "2MZ4fipENt0pJIApPXc4aoUtCQ+lrTE2IFw6Ea7e58A=";
}
