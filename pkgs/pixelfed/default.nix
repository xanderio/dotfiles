{
  pkgs,
  stdenv,
  lib,
  fetchFromGitHub,
  dataDir ? "/var/lib/pixelfed",
  ...
}: let
  composerLock = ./composer.lock;
  package =
    (import ./composition.nix
      {
        inherit pkgs;
        inherit (stdenv.hostPlatform) system;
        noDev = true; # Disable development dependencies
      })
    .overrideAttrs (attrs: rec {
      installPhase =
        ''
          # hack for missing lock file upstream
          cp -av $src $out
          chmod -R u+w $out
          cp -v ${composerLock} $out/composer.lock
        ''
        + attrs.installPhase
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
      rev = "7a0acebffb7ca0531d7e0f8b63d164d7d341a034";
      sha256 = "mBX3JJSJaPywe1MxGmapLLOklBhuhR3AautA5VJ3MEU=";
    };
  }
