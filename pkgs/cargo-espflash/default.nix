{ lib
, fetchFromGitHub
, rustPlatform
, pkg-config
, libuv
, systemd
,
}:
rustPlatform.buildRustPackage rec {
  pname = "espflash";
  version = "1.6.0";

  src = fetchFromGitHub {
    owner = "esp-rs";
    repo = pname;
    rev = "v${version}";
    sha256 = "YQ621YbdEy2sS4uEYvgnQU1G9iW5SpWNObPH4BfyeF0=";
  };

  buildInputs = [ libuv systemd.dev ];
  nativeBuildInputs = [ pkg-config ];

  cargoSha256 = "do0rjujlLyEjCnKfbFnblyxrGYguDQ70j9KJcUAYi+w=";
}
