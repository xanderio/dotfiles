{
  pkgs,
  stdenv,
  lib,
  fetchFromGitHub,
  dataDir ? "/var/lib/pixelfed",
  ...
}: let
  package =
    (import ./composition.nix
      {
        inherit pkgs;
        inherit (stdenv.hostPlatform) system;
        noDev = true; # Disable development dependencies
      })
    .overrideAttrs (attrs: rec {
      installPhase =
        attrs.installPhase
        + ''
          ${pkgs.php}/bin/php $out/artisan horizon:publish
          ${pkgs.php}/bin/php $out/artisan horizon:install
          mv $out/storage $out/storage_dist
          mv $out/bootstrap $out/bootstrap_dist
          ln -s ${dataDir}/.env $out/.env
          ln -s ${dataDir}/storage $out/storage
          ln -s ${dataDir}/bootstrap $out/bootstrap
        '';
    });
in
  package.override rec {
    pname = "pixelfed";
    version = "0.11.2";

    src = fetchFromGitHub {
      owner = pname;
      repo = pname;
      rev = "v${version}";
      sha256 = "uk06OERuNIqMsYJBa7BosgP0v3Li9FqhZ6SDDnmttyk=";
    };
  }
