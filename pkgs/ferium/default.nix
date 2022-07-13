{
  lib,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
}:
rustPlatform.buildRustPackage rec {
  pname = "ferium";
  version = "4.1.2";

  src = fetchFromGitHub {
    owner = "gorilla-devs";
    repo = pname;
    rev = "v${version}";
    sha256 = "qx1NP+qmkre+WMjFMB2O6HLOf/tDX3RxCvn+87w8qwo=";
  };
  buildNoDefaultFeatures = true;
  doCheck = false;

  nativeBuildInputs = [pkg-config];

  cargoSha256 = "llEZmgIHc/jQwFV3URoQghg/aM0qIu5wBKQQkAGoBmg=";
}
