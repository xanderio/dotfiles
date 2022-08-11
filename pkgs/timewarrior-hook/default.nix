{ pkgs
, stdenvNoCC
, ...
}:
stdenvNoCC.mkDerivation rec {
  name = "on-modify.timewarrior";

  src = ./on-modify.timewarrior;

  buildInputs = [ pkgs.python3 ];

  dontUnpack = true;
  dontBuild = true;
  installPhase = ''
    cp $src $out
  '';
}
