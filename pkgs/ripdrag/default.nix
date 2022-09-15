{ lib
, fetchFromGitHub
, rustPlatform
, gtk4
, pkg-config
,
}:
rustPlatform.buildRustPackage rec {
  pname = "ripdrag";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "nik012003";
    repo = pname;
    rev = "1ba3d98b3dfd9fa5f683e92c7a10ea2364686b34";
    sha256 = "v/n+r6A1QSOg6PaAFQALnxjzO8xebJ3mKBoi0xOxvh8=";
  };

  buildInputs = [ gtk4 ];
  nativeBuildInputs = [ pkg-config ];

  cargoSha256 = "sha256-Yp4VraM/xh9Rhxkg06+4ywYclU4eT1G96mmIyv73hRY=";
}
